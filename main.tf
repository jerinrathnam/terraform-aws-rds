
data "aws_availability_zones" "this" {
  state = "available"
}

locals {
  azs = data.aws_availability_zones.this.names
}

########################## DB INSTANCE #############################

resource "aws_db_instance" "this" {
  count = var.create_cluster ? 0 : 1

  allocated_storage                     = var.allocated_storage
  allow_major_version_upgrade           = var.allow_major_version_upgrade
  apply_immediately                     = var.apply_immediately
  availability_zone                     = var.availability_zone
  backup_retention_period               = var.backup_retention_period
  backup_window                         = var.backup_window
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  delete_automated_backups              = var.delete_automated_backups
  deletion_protection                   = var.db_deletion_protection
  db_name                               = var.database_name
  db_subnet_group_name                  = var.db_subnet_group_name == null ? aws_db_subnet_group.this[0].id : var.db_subnet_group_name
  enabled_cloudwatch_logs_exports       = var.cloudwatch_logs_exports
  engine                                = var.engine_type
  engine_version                        = var.engine_version
  final_snapshot_identifier             = "${var.name}-final-snapshot"
  kms_key_id                            = var.kms_key_id
  identifier                            = var.name
  instance_class                        = var.instance_class
  iops                                  = var.iops
  maintenance_window                    = var.maintenance_window
  max_allocated_storage                 = var.max_allocated_storage
  monitoring_interval                   = var.monitoring_interval
  monitoring_role_arn                   = var.monitoring_role_arn
  network_type                          = var.network_type
  username                              = var.master_username
  parameter_group_name                  = var.db_parameter_group_name == null ? aws_db_parameter_group.this[0].id : var.db_parameter_group_name
  password                              = var.master_password
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = var.performance_insights_enabled ? var.kms_key_id : null
  performance_insights_retention_period = var.performance_insights_retention_period
  port                                  = var.port
  publicly_accessible                   = var.public_access
  skip_final_snapshot                   = var.skip_final_snapshot
  snapshot_identifier                   = var.snapshot_identifier
  storage_type                          = var.storage_type
  vpc_security_group_ids                = var.security_group_ids

  blue_green_update {
    enabled = var.blue_green_update_enable
  }

  lifecycle {
    ignore_changes = [
      snapshot_identifier
    ]
  }

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

############################ DB CLUSTER ################################

resource "aws_rds_cluster" "this" {
  count = var.create_cluster ? 1 : 0

  allocated_storage               = var.allocated_storage
  allow_major_version_upgrade     = var.allow_major_version_upgrade
  availability_zones              = slice(local.azs, 0, 2)
  apply_immediately               = var.apply_immediately
  backup_retention_period         = var.backup_retention_period
  cluster_identifier              = var.name
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  database_name                   = var.database_name
  deletion_protection             = var.db_deletion_protection
  db_cluster_parameter_group_name = var.cluster_parameter_gp_name == null ? aws_rds_cluster_parameter_group.this[0].id : var.cluster_parameter_gp_name
  db_subnet_group_name            = var.db_subnet_group_name == null ? aws_db_subnet_group.this[0].id : var.db_subnet_group_name
  enabled_cloudwatch_logs_exports = var.cloudwatch_logs_exports
  engine                          = var.engine_type
  engine_mode                     = var.engine_mode
  engine_version                  = var.engine_version
  final_snapshot_identifier       = "${var.name}-final-snapshot"
  iops                            = var.iops
  kms_key_id                      = var.kms_key_id
  master_username                 = var.master_username
  master_password                 = var.master_password
  network_type                    = var.network_type
  port                            = var.port
  preferred_backup_window         = var.backup_window
  preferred_maintenance_window    = var.maintenance_window
  skip_final_snapshot             = var.skip_final_snapshot
  snapshot_identifier             = var.snapshot_identifier
  storage_type                    = var.storage_type
  storage_encrypted               = var.encrypt_storage
  vpc_security_group_ids          = var.security_group_ids

  dynamic "serverlessv2_scaling_configuration" {
    for_each = var.instance_class == "db.serverless" ? [1] : []

    content {
      max_capacity = var.serverlessv2_max_capacity
      min_capacity = var.serverlessv2_min_capacity
    }
  }

  lifecycle {
    ignore_changes = [
      snapshot_identifier,
      availability_zones
    ]
  }

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

########################### DB CLUSTER INSTANCE ###############################

resource "aws_rds_cluster_instance" "this" {
  count = var.create_cluster ? var.cluster_db_count : 0

  availability_zone                     = var.cluster_db_count == 1 ? var.availability_zone : local.azs[count.index]
  cluster_identifier                    = aws_rds_cluster.this[0].id
  db_parameter_group_name               = var.db_parameter_group_name == null ? aws_db_parameter_group.this[0].id : var.db_parameter_group_name
  db_subnet_group_name                  = var.db_subnet_group_name == null ? aws_db_subnet_group.this[0].id : var.db_subnet_group_name
  engine                                = aws_rds_cluster.this[0].engine
  engine_version                        = aws_rds_cluster.this[0].engine_version
  identifier                            = var.cluster_db_count == 1 ? var.name : "${var.name}-${count.index}"
  instance_class                        = var.instance_class
  monitoring_interval                   = var.monitoring_interval
  monitoring_role_arn                   = var.monitoring_role_arn
  publicly_accessible                   = var.public_access
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = var.performance_insights_enabled ? var.kms_key_id : null
  performance_insights_retention_period = var.performance_insights_retention_period

  lifecycle {
    ignore_changes = [
      availability_zone
    ]
  }

  tags = merge(
    {
      "Name" = var.cluster_db_count == 1 ? var.name : "${var.name}-${count.index}"
    },
    var.tags
  )
}

########################## DB PARAMETER GROUP ################################

resource "aws_db_parameter_group" "this" {
  count = var.db_parameter_group_name == null ? 1 : 0

  name   = "${var.name}-db-pg"
  family = var.parameter_group_family

  dynamic "parameter" {
    for_each = var.db_parameters != null ? var.db_parameters : {}
    content {
      name         = parameter.key
      value        = parameter.value
      apply_method = var.parameter_apply_method
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    {
      "Name" = "${var.name}-db-pg"
    },
    var.tags
  )
}

########################## CLUSTER PARAMETER GROUP ##############################

resource "aws_rds_cluster_parameter_group" "this" {
  count = var.create_cluster && var.cluster_parameter_gp_name == null ? 1 : 0

  name        = "${var.name}-cluster-pg"
  family      = var.parameter_group_family
  description = "RDS ${var.parameter_group_family} cluster parameter group"

  dynamic "parameter" {
    for_each = var.cluster_parameters != null ? var.cluster_parameters : {}
    content {
      name         = parameter.key
      value        = parameter.value
      apply_method = var.parameter_apply_method
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    {
      "Name" = "${var.name}-cluster-pg"
    },
    var.tags
  )
}

############################## DB SUBNET GROUP ###############################

resource "aws_db_subnet_group" "this" {
  count = var.db_subnet_group_name == null ? 1 : 0

  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(
    {
      "Name" = "${var.name}-subnet-group"
    },
    var.tags
  )
}