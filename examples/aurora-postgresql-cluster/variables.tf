variable "master_username" {
  type        = string
  description = "Master username for the Database cluster"
}

variable "master_password" {
  type        = string
  description = "Master password for the username of the Database cluster"
}

variable "db_name" {
  type        = string
  description = "Database name needs to be create"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet ids for the Database"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for the Database"
}