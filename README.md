# AWS Backup Terraform Module

This Terraform module provisions AWS Backup resources, including backup vaults, backup plans, IAM roles, and resource assignments for EC2, EBS, and RDS. It is designed to be flexible and reusable for different AWS environments.

## Pre-requisites

- [Terraform](https://www.terraform.io/downloads.html) v0.12 or later
- AWS CLI configured with appropriate credentials
- An AWS account with permissions to create IAM roles, policies, backup plans, and assign resources

## Inputs Required

Below are the variables you need to provide in the `terraform.tfvars` file or via environment variables:

| Variable Name            | Description                                                      | Type     | Example Value                |
|------------------------- |------------------------------------------------------------------|----------|------------------------------|
| `vault_name`             | Name of the AWS Backup Vault                                     | string   | "my-backup-vault"           |
| `encryption_key_arn`     | ARN of the KMS key for encryption (optional)                     | string   | "arn:aws:kms:..."           |
| `project`                | Project name                                                     | string   | "MyProject"                 |
| `project_code`           | Project code                                                     | string   | "PRJ001"                    |
| `business_unit`          | Business unit name                                               | string   | "IT"                        |
| `additional_tags`        | Additional tags to apply to resources                            | map      | `{ Environment = "dev" }`   |
| `backup_role_arn`        | Existing IAM role ARN for backup (optional)                      | string   | null                         |
| `backup_plan_name`       | Name for the backup plan                                         | string   | "my-backup-plan"            |
| `backup_rule_name`       | Name for the backup rule                                         | string   | "daily-backup"              |
| `backup_frequency`       | Frequency: "daily", "weekly", or "monthly"                     | string   | "daily"                     |
| `backup_start_time`      | Start time in HH:MM (24h) format                                 | string   | "02:00"                     |
| `weekly_start_day`       | Day of week for weekly backups (e.g., "MON")                    | string   | "MON"                       |
| `monthly_start_day`      | Day of month for monthly backups (e.g., "1")                    | string   | "1"                         |
| `start_within_hours`     | Start window in hours                                            | number   | 1                            |
| `complete_within_hours`  | Completion window in hours                                       | number   | 2                            |
| `retention_period_days`  | Number of days to retain backups                                 | number   | 30                           |
| `resource_assignment_name`| Name prefix for resource assignments                            | string   | "my-backup-assignment"      |
| `aws_region`             | AWS region                                                       | string   | "us-east-1"                 |
| `aws_account_id`         | AWS account ID                                                   | string   | "123456789012"              |
| `ec2_instance_ids`       | List of EC2 instance IDs to back up                              | list     | ["i-0123456789abcdef0"]     |
| `ebs_volume_ids`         | List of EBS volume IDs to back up                                | list     | ["vol-0123456789abcdef0"]   |
| `rds_instance_names`     | List of RDS instance names to back up                            | list     | ["mydbinstance"]            |

> **Note:** All variables are defined in `variables.tf`. You can override them in `terraform.tfvars`.

## How to Use

1. **Clone the repository or copy the module files** to your working directory.

2. **Configure your AWS credentials** (via AWS CLI, environment variables, or shared credentials file).

3. **Edit `terraform.tfvars`** to provide values for all required variables. Example:

    ```hcl
    vault_name              = "my-backup-vault"
    project                 = "MyProject"
    project_code            = "PRJ001"
    business_unit           = "IT"
    backup_plan_name        = "my-backup-plan"
    backup_rule_name        = "daily-backup"
    backup_frequency        = "daily"
    backup_start_time       = "02:00"
    start_within_hours      = 1
    complete_within_hours   = 2
    retention_period_days   = 30
    resource_assignment_name= "my-backup-assignment"
    aws_region              = "us-east-1"
    aws_account_id          = "123456789012"
    ec2_instance_ids        = ["i-0123456789abcdef0"]
    ebs_volume_ids          = ["vol-0123456789abcdef0"]
    rds_instance_names      = ["mydbinstance"]
    additional_tags         = { Environment = "dev" }
    # encryption_key_arn and backup_role_arn are optional
    ```

4. **Initialize Terraform:**

    ```powershell
    terraform init
    ```

5. **Review the execution plan:**

    ```powershell
    terraform plan
    ```

6. **Apply the configuration:**

    ```powershell
    terraform apply
    ```

7. **(Optional) Destroy resources:**

    ```powershell
    terraform destroy
    ```

## Notes
- Ensure your AWS user/role has permissions to create IAM roles, policies, backup plans, and assign resources.
- If you want to use an existing IAM role for backup, provide its ARN in `backup_role_arn`.
- For more details on each variable, see `variables.tf`.

## Outputs
- See `outputs.tf` for the outputs provided by this module.
