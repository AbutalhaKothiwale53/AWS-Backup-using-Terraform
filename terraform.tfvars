## All Inputs Needs to be provided in this File

## AWS Configuration
# AWS Account ID
aws_account_id = "01234567890"
# AWS Region Where the Backup needed for the resources
aws_region = "ap-south-1"

## Vault Configuration
# Vault Name
vault_name = "Automated_Test_Vault"
# KMS/CMK Key ARN
encryption_key_arn = "arn:aws:kms:ap-south-1:01234567890:key/28a903b9-aca0-4e45-8904-fb1047c4fba3"

## Backup Plan Configuration
# AWS Backup Plan Name
backup_plan_name = "Automated_Test_Backup_Plan"

## Backup Rule Configuration
# Backup Rule Name
backup_rule_name = "Automated_Test_Backup_Rule"
# Backup Frequency
# Note : Any Once Backup frequency should be provided i.e. daily, weekly, monthly
# For Daily
backup_frequency = "daily"
# For Weekly backups specify the start day
#weekly_start_day = "Mon" # Options: Mon, Tue, Wed, Thu, Fri, Sat, Sun
# For Monthly backups specify month start day
#monthly_start_day = 1 # Options: 1 to 30 days

#Backup Window Configuration (UTC TimeZone)
backup_start_time = "08:30"   # Format: HH:MM
start_within_hours = 1        # Start backup within 1 hour
complete_within_hours = 2     # Complete backup time can be provided from 2 to 8 hours for completion       

# Retention Period
retention_period_days = 1
# Resource Assingment Configuration
resource_assignment_name = "Automated_Test_Resources"
backup_role_arn = "arn:aws:iam::01234567890:role/AWSBackupDefaultServiceRole" # Optional

## Assinging Resource for Backup rule
# Note: You can provide single or any combination of resources types. But Provide atleast any one resource type
ec2_instance_ids = [
    "i-0ecec8d2f0dfe7fde5"
]
ebs_volume_ids = [
    "vol-0ae3b2aeba9047e42"
]
rds_instance_names = [
    #"my_DB_Name"
]

## Tags
# Common Tags
project = "Automation"
project_code = "ABCD"
business_unit = "Automn"

# Additoinal tags
additional_tags = {
  "Environment" = "Production"
  "Owner" = "Abutalha"
}