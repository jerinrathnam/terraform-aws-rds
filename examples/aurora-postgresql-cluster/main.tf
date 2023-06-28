module "rds" {
  source = "../../"

  engine_type            = "aurora-postgresql"
  engine_version         = "14.5"
  parameter_group_family = "aurora-postgresql14"
  master_username        = var.master_username
  master_password        = var.master_password
  name                   = var.db_name
  subnet_ids             = var.subnet_ids
  security_group_ids     = [var.security_group_id]

  tags = {
    "Env" = "Development"
  }
}