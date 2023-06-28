
module "rds" {
  source = "../../"

  create_cluster         = false
  allocated_storage      = 20
  engine_type            = "mysql"
  engine_version         = "8.0"
  parameter_group_family = "mysql8"
  master_username        = var.master_username
  master_password        = var.master_password
  name                   = var.db_name
  subnet_ids             = var.subnet_ids
  security_group_ids     = [var.security_group_id]

  tags = {
    "Env" = "Development"
  }
}
