## AWS Backup Vault
resource "aws_backup_vault" "main" {
  name = var.vault_name
  kms_key_arn =  var.encryption_key_arn
  tags = merge(
    {
      "Name"           = var.vault_name,
      "Project"        = var.project,
      "ProjectCode"    = var.project_code,
      "BusinessUnit"   = var.business_unit,
      "CreatedOn"      = timestamp(),
    },
    var.additional_tags)
}

## IAM role fpr AWS Backup Service (created if not provided)
data "aws_iam_policy_document" "backup_assume_role" {
  count = var.backup_role_arn == null ? 1 : 0
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "backup_role" {
  count = var.backup_role_arn == null ? 1 : 0
  name = "${var.backup_plan_name}_Backup_Role"
  assume_role_policy = data.aws_iam_policy_document.backup_assume_role[0].json
  tags = merge({
    Name = "${var.backup_plan_name}_Backup_Role"
    Project = var.project
    ProjectCode = var.project_code
    BusinessUnit = var.business_unit
  }, var.additional_tags)
}
resource "aws_iam_role_policy_attachment" "backup_policy" {
  count = var.backup_role_arn == null ? 1 : 0
  role = aws_iam_role.backup_role[0].name
  policy_arn = "arn:aws:iam:aws:policy/service-role/AWSBackupServiceRolePolicyForBakup"
}
resource "aws_iam_role_policy_attachment" "restore_policy" {
  count = var.backup_role_arn == nul ? 1 : 0
  role = aws_iam_role.backup_role[0].name
  policy_arn = "arn:aws:iam:aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

## Local Vaules for Schedule Expression
locals {
  schedule_expression = var.backup_frequency == "daily" ? "cron(${split(":", var.backup_start_time)[1]} ${split(":", var.backup_start_time)[0]} * * ? * )" : var.backup_frequency == "weekly" ? "cron(${split(":", var.backup_start_time)[1]} ${split(":", var.backup_start_time)[0]} ? * ${upper(substr(var.weekly_start_day, 0, 3))} *)" : "cron(${split(":", var.backup_start_time)[1]} ${split(":", var.backup_start_time)[0]} ${var.monthly_start_day} * ? * )"

  backup_plan_arn = var.backup_role_arn != null ? backup_role_arn : aws_iam_role.backup_role[0].arn
}

## AWS Backup Plan
resource "aws_backup_plan" "main" {
  name = var.backup_plan_name
  rule {
    rule_name = var.backup_rule_name
    target_vault_name = aws_backup_vault.main.name
    schedule = local.schedule_expression
    start_window = var.start_within_hours * 60
    completion_window = var.complete_within_hours * 60
    
    lifecycle {
      delete_after = var.retention_period_days
    }

    recovery_point_tags = merge({
        Name = "${var.backup_rule_name}_Recovery_Point"
        Project = var.project
        ProjectCode = var.project_code
        BusinessUnit = var.business_unit
    }, additional_tags)
  }
  tags = merge({
    Name = var.backup_plan_name
        Project = var.project
        ProjectCode = var.project_code
        BusinessUnit = var.business_unit
    }, additional_tags)
}

# Resource assignment for EC2 Instances
resource "aws_backup_selection" "ec2_selection" {
   count = length(var.ec2_instance_ids) > 0 ? 1: 0
   iam_role_arn = local.backup_plan_arn
   name = "${var.resource_assignment_name}_EC2"
   plan_id = aws_backup_plan.main.name
   resources = [for instance_id in var.ec2_instance_ids : "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:instance/${instance_id}"]
}

# Resource assignment for EBS Volumes
resource "aws_backup_selection" "ebs_selection" {
   count = length(var.ebs_volume_ids) > 0 ? 1: 0
   iam_role_arn = local.backup_plan_arn
   name = "${var.resource_assignment_name}_EBS"
   plan_id = aws_backup_plan.main.name
   resources = [for volume_id in var.ebs_volume_ids : "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:volume/${volume_id}"]
}

# Resource assignment for RDS Instances
resource "aws_backup_selection" "rds_selection" {
   count = length(var.rds_instance_names) > 0 ? 1: 0
   iam_role_arn = local.backup_plan_arn
   name = "${var.resource_assignment_name}_RDS"
   plan_id = aws_backup_plan.main.name
   resources = [for rds_name in var.rds_instance_names : "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:db/${rds_name}"]
}
