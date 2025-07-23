variable "vault_name" {
  description = "The name of the backup vault."
  type        = string
}

variable "encryption_key_arn" {
  description = "The ARN of the KMS key used for encryption."
  type        = string
  default = null
}

variable "backup_plan_name" {
  description = "The name of the backup plan."
  type        = string
}

variable "backup_rule_name" {
  description = "The name of the backup rule."
  type        = string  
}

variable "backup_frequency" {
  description = "The frequency: daily, weekly, monthly."
  type        = string
  validation {
    condition = contains((["daily, weekly, monthly"]), var.backup_frequency)
    error_message = "Backup frequency must be one of: daily, weekly, monthly."
  }
}
variable "weekly_start_day" {
  description = "The day of the week to start the backup."
  type        = string
  default = "Mon"
  validation {
    condition = contains((["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]), var.weekly_start_day)
    error_message = "Weekly start day must be one of: MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY."
  }
}
variable "monthly_start_day" {
  description = "The day of the month to start the backup."
  type        = number
  default = 1
  validation {
    condition = var.monthly_start_day >= 1 && var.monthly_start_day <= 30
    error_message = "Monthly start day must be between 1 and 30."
  }
}

variable "backup_start_time" {
  description = "Backup start time in UTC (HH:MM) format."
  type = string
  default = "00:00"
}

variable "start_within_hours" {
  description = "Start backup within specified hours"
  type = number
  default = 1
}
variable "complete_within_hours" {
  description = "Complete within specified hours."
  type = number
  default = 8
}

variable "retention_period_days" {
  description = "The number of days to retain backups."
  type = number
  default = 35  
}

variable "resource_assignment_name" {
  description = "Name of resource assignment."
  type = string
}

variable "backup_role_arn" {
  description = "The ARN of the IAM role used for backup."
  type = string 
  default = "arn:aws:iam::01234567890:role/AWSBackupDefaultServiceRole"
}

variable "ec2_instance_ids" {
  description = "List of EC2 instance IDs to be backed up."
  type = list(string)
  default = []
}

variable "rds_instance_names" {
  description = "List of RDS instance names to be backed up."
  type = list(string)
  default = []
}

variable "ebs_volume_ids" {
  description = "List of EBS volume IDs to be backed up."
  type = list(string)
  default = []  
}

variable "aws_account_id" {
  description = "The AWS account ID where the backup vault is created."
  type = string  
}

variable "aws_region" {
  description = "AWS region for the resources."
  default = "ap-southeast-1"
  type = string
}

variable "project" {
  description = "Project name for tagging."
  type = string
}

variable "project_code" {
  description = "Project code for tagging."
  type = string  
}

variable "business_unit" {
  description = "Business unit for tagging."
  type = string    
}

variable "additional_tags" {
  description = "Additional tags for the resources."
  type = map(string)
  default = {}
}

