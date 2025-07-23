output "backup_vault_name" {
  description = "Name of the backup vault."
  value       = aws_backup_vault.main.name  
}
output "backup_vault_arn" {
  description = "ARN of the backup vault."
  value       = aws_backup_vault.main.arn  
}
output "backup_plan_id" {
  description = "ID of the backup plan."
  value       = aws_backup_plan.main.id  
}
output "backup_plan_arn" {
  description = "ARN of the backup plan."
  value       = aws_backup_plan.main.arn  
}
output "backup_role_arn" {
  description = "ARN of the IAM role used for backup."
  value       = aws_iam_role.backup_role.arn    
}
output "ec2_selection_id" {
    description = "ID of the EC2 backup selection."
    value       = length(aws_backup_selection.ec2_selection) > 0 ? aws_backup_selection.ec2_selection[0].id : null
}
output "rds_selection_id" {
    description = "ID of the RDS backup selection."
    value       = length(aws_backup_selection.rds_selection) > 0 ? aws_backup_selection.rds_selection[0].id : null
}
output "ebs_selection_id" {
    description = "ID of the EBS backup selection."
    value       = length(aws_backup_selection.ebs_selection) > 0 ? aws_backup_selection.ebs_selection[0].id : null
}
output "schedule_expression" {
    description = "Cron expression for the backup schedule."
    value       = local.schedule_expression
}