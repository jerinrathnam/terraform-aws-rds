variable "allocated_storage" {
  type        = number
  description = "allocated storage for database"
  default     = null
}

variable "allow_major_version_upgrade" {
  type        = bool
  description = "Whether to allow or not major version upgrade"
  default     = true
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = true
}

variable "availability_zone" {
  type        = string
  description = "The AZ for the RDS instance."
  default     = null
}

variable "backup_retention_period" {
  type        = number
  description = "The days to retain backups for. Must be between 1 and 35"
  default     = 1
}

variable "backup_window" {
  type        = string
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled"
  default     = null
}

variable "blue_green_update_enable" {
  type        = bool
  description = "Enables low-downtime updates using RDS Blue/Green deployments"
  default     = false
}

variable "cloudwatch_logs_exports" {
  type        = list(string)
  description = "Set of log types to enable for exporting to CloudWatch logs"
  default     = []
}

variable "cluster_db_count" {
  type        = number
  description = "Count of db cluster instances could be created"
  default     = 1
}

variable "cluster_parameters" {
  type        = map(any)
  description = "Parameters for cluster parameter group"
  default     = null
}

variable "cluster_parameter_gp_name" {
  type        = string
  description = "Name of the cluster parameter group. If need to create new one, leave it to 'null'"
  default     = null
}

variable "copy_tags_to_snapshot" {
  type        = bool
  description = "Copy all Instance tags to snapshots"
  default     = false
}

variable "create_cluster" {
  type        = bool
  description = "Whether or not to create cluster"
  default     = true
}

variable "database_name" {
  type        = string
  description = "database name for the database instance"
  default     = null
}

variable "delete_automated_backups" {
  type        = bool
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted"
  default     = true
}

variable "db_deletion_protection" {
  type        = bool
  description = "If the DB instance should have deletion protection enabled"
  default     = false
}

variable "db_parameters" {
  type        = map(any)
  description = "Parameters for db parameter group"
  default     = null
}

variable "db_parameter_group_name" {
  type        = string
  description = "Name of the db parameter group. If need to create new one, leave it to 'null'"
  default     = null
}

variable "db_subnet_group_name" {
  type        = string
  description = "Name of the subnet group. If need to create new one, leave it to 'null'"
  default     = null
}

variable "engine_mode" {
  type        = string
  description = "The database engine mode"
  default     = "provisioned"
}

variable "engine_type" {
  type        = string
  description = "Datatabse instance engine type"
  default     = null
}

variable "engine_version" {
  type        = string
  description = "Database instance engine version"
  default     = null
}

variable "encrypt_storage" {
  type        = bool
  description = "Whether to encrypt storage or not"
  default     = true
}

variable "instance_class" {
  type        = string
  description = "DB Instance type"
  default     = "db.t4g.medium"
}

variable "iops" {
  type        = number
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of io1"
  default     = null
}

variable "kms_key_id" {
  type        = string
  description = "The ARN for the KMS encryption key"
  default     = null
}

variable "maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: ddd:hh24:mi-ddd:hh24:mi"
  default     = null
}

variable "master_password" {
  type        = string
  description = "Database master password"
  default     = null
}

variable "master_username" {
  type        = string
  description = "Database master user name"
  default     = null
}

variable "max_allocated_storage" {
  type        = number
  description = "Maximum allocated storage size for database"
  default     = 100
}

variable "monitoring_interval" {
  type        = number
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
  default     = 0
}

variable "monitoring_role_arn" {
  type        = string
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  default     = null
}

variable "name" {
  type        = string
  description = "Name for the DB Instance and cluster"
}

variable "network_type" {
  type        = string
  description = "The network type of the DB instance. Valid values: IPV4, DUAL."
  default     = "IPV4"
}

variable "parameter_apply_method" {
  type        = string
  description = "immediate (default), or pending-reboot"
  default     = "immediate"
}

variable "parameter_group_family" {
  type        = string
  description = "Parameter group faminly"
  default     = null
}

variable "performance_insights_enabled" {
  type        = bool
  description = "Specifies whether Performance Insights are enabled"
  default     = false
}

variable "performance_insights_retention_period" {
  type        = number
  description = "Amount of time in days to retain Performance Insights data"
  default     = null
}

variable "port" {
  type        = number
  description = "port for database connection"
  default     = null
}

variable "public_access" {
  type        = bool
  description = "Whether the database could publicly accessible"
  default     = false
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group ids"
  default     = null
}

variable "serverlessv2_max_capacity" {
  type        = number
  description = "Maximum capacity for an Aurora DB cluster in provisioned DB engine mode. The maximum capacity must be greater than or equal to the minimum capacity. Valid capacity values are in a range of 0.5 up to 128 in steps of 0.5."
  default     = 0.5
}

variable "serverlessv2_min_capacity" {
  type        = number
  description = "Minimum capacity for an Aurora DB cluster in provisioned DB engine mode. The minimum capacity must be lesser than or equal to the maximum capacity. Valid capacity values are in a range of 0.5 up to 128 in steps of 0.5."
  default     = 1.0
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Whether to skip to create snapshot while delete the database"
  default     = true
}

variable "snapshot_identifier" {
  type        = string
  description = "Specifies whether or not to create this database from a snapshot"
  default     = null
}

variable "storage_type" {
  type        = string
  description = "Type of  storage for database"
  default     = null
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of the DB tier subnet ids"
  default     = null
}

variable "tags" {
  type        = map(any)
  description = "Tags for database instance and cluster"
  default     = null
}