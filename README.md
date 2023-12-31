## Intoduction

This Terraform module for ***AWS RDS (Relational Database Service)*** provides a convenient and efficient way to provision and manage RDS database instances and related resources in your AWS environment. With this module, you can define and configure RDS instances, including their database engine, storage, instance size, security settings, and more, using a declarative infrastructure-as-code approach.

This module offers a variety of features and benefits. It abstracts the complexity of manually provisioning and configuring RDS resources, allowing you to define your desired state and infrastructure requirements in a clear and concise manner. This module follows best practices and guidelines, ensuring that your RDS instances are provisioned with recommended security settings, performance configurations, and backup strategies.

This module supports various database engines provided by AWS, such as MySQL, PostgreSQL, Oracle, and SQL Server, allowing you to choose the most suitable database solution for your application needs. You can use this moudle to create RDS Cluster, RDS DB Instance DB Subnets and DB Parameter groups.

The module also integrates well with other AWS services and resources, enabling you to define connections, security groups, parameter groups, and snapshots associated with your RDS instances. This allows for seamless integration with your existing AWS infrastructure and promotes a comprehensive and scalable architecture.

Additionally, the Terraform module for AWS RDS provides support for advanced features such as Multi-AZ deployments, Read Replicas, database encryption, and automated backups. This allows you to build highly available and fault-tolerant database solutions while maintaining data integrity and security.

## Usage

### Sample RDS cluster

```
  module "rds" {
    source = "jerinrathnam/rds/aws"

    engine_type             = "aurora-postgresql"
    engine_version          = "14.5"
    parameter_group_family  = "aurora-postgresql14"
    master_username         = var.master_username
    master_password         = var.master_password
    name                    = var.db_name
    subnet_ids              = var.subnet_ids
    security_group_ids      = [var.security_group_id]

    tags = {
      "Env" = local.environment
    }
  }
```

## Example

- [Aurora PostgreSQL Cluster](https://github.com/jerinrathnam/terraform-aws-rds/tree/main/examples/aurora-postgresql-cluster)
- [RDS MySQL DB Instance](https://github.com/jerinrathnam/terraform-aws-rds/tree/main/examples/mysql-db-instance)


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.55.0 |

## Description

This module will create RDS Database instance or RDS database Cluster along with DB Parameter groups and Subnet groups.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_rds_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_availability_zones.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | allocated storage for database | `number` | `null` | no |
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | Whether to allow or not major version upgrade | `bool` | `true` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `true` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The AZ for the RDS instance. | `string` | `null` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for. Must be between 1 and 35 | `number` | `1` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | The daily time range (in UTC) during which automated backups are created if they are enabled | `string` | `null` | no |
| <a name="input_blue_green_update_enable"></a> [blue\_green\_update\_enable](#input\_blue\_green\_update\_enable) | Enables low-downtime updates using RDS Blue/Green deployments | `bool` | `false` | no |
| <a name="input_cloudwatch_logs_exports"></a> [cloudwatch\_logs\_exports](#input\_cloudwatch\_logs\_exports) | Set of log types to enable for exporting to CloudWatch logs | `list(string)` | `[]` | no |
| <a name="input_cluster_db_count"></a> [cluster\_db\_count](#input\_cluster\_db\_count) | Count of db cluster instances could be created | `number` | `1` | no |
| <a name="input_cluster_parameter_gp_name"></a> [cluster\_parameter\_gp\_name](#input\_cluster\_parameter\_gp\_name) | Name of the cluster parameter group. If need to create new one, leave it to 'null' | `string` | `null` | no |
| <a name="input_cluster_parameters"></a> [cluster\_parameters](#input\_cluster\_parameters) | Parameters for cluster parameter group | `map(any)` | `null` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | Copy all Instance tags to snapshots | `bool` | `false` | no |
| <a name="input_create_cluster"></a> [create\_cluster](#input\_create\_cluster) | Whether or not to create cluster | `bool` | `true` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | database name for the database instance | `string` | `null` | no |
| <a name="input_db_deletion_protection"></a> [db\_deletion\_protection](#input\_db\_deletion\_protection) | If the DB instance should have deletion protection enabled | `bool` | `false` | no |
| <a name="input_db_parameter_group_name"></a> [db\_parameter\_group\_name](#input\_db\_parameter\_group\_name) | Name of the db parameter group. If need to create new one, leave it to 'null' | `string` | `null` | no |
| <a name="input_db_parameters"></a> [db\_parameters](#input\_db\_parameters) | Parameters for db parameter group | `map(any)` | `null` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | Name of the subnet group. If need to create new one, leave it to 'null' | `string` | `null` | no |
| <a name="input_delete_automated_backups"></a> [delete\_automated\_backups](#input\_delete\_automated\_backups) | Specifies whether to remove automated backups immediately after the DB instance is deleted | `bool` | `true` | no |
| <a name="input_encrypt_storage"></a> [encrypt\_storage](#input\_encrypt\_storage) | Whether to encrypt storage or not | `bool` | `true` | no |
| <a name="input_engine_mode"></a> [engine\_mode](#input\_engine\_mode) | The database engine mode | `string` | `"provisioned"` | no |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | Datatabse instance engine type | `string` | `null` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Database instance engine version | `string` | `null` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | DB Instance type | `string` | `"db.t4g.medium"` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | The amount of provisioned IOPS. Setting this implies a storage\_type of io1 | `number` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key | `string` | `null` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The window to perform maintenance in. Syntax: ddd:hh24:mi-ddd:hh24:mi | `string` | `null` | no |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | Database master password | `string` | `null` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | Database master user name | `string` | `null` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | Maximum allocated storage size for database | `number` | `100` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance | `number` | `0` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the DB Instance and cluster | `string` | n/a | yes |
| <a name="input_network_type"></a> [network\_type](#input\_network\_type) | The network type of the DB instance. Valid values: IPV4, DUAL. | `string` | `"IPV4"` | no |
| <a name="input_parameter_apply_method"></a> [parameter\_apply\_method](#input\_parameter\_apply\_method) | immediate (default), or pending-reboot | `string` | `"immediate"` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | Parameter group faminly | `string` | `null` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Specifies whether Performance Insights are enabled | `bool` | `false` | no |
| <a name="input_performance_insights_retention_period"></a> [performance\_insights\_retention\_period](#input\_performance\_insights\_retention\_period) | Amount of time in days to retain Performance Insights data | `number` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | port for database connection | `number` | `null` | no |
| <a name="input_public_access"></a> [public\_access](#input\_public\_access) | Whether the database could publicly accessible | `bool` | `false` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group ids | `list(string)` | `null` | no |
| <a name="input_serverlessv2_max_capacity"></a> [serverlessv2\_max\_capacity](#input\_serverlessv2\_max\_capacity) | Maximum capacity for an Aurora DB cluster in provisioned DB engine mode. The maximum capacity must be greater than or equal to the minimum capacity. Valid capacity values are in a range of 0.5 up to 128 in steps of 0.5. | `number` | `0.5` | no |
| <a name="input_serverlessv2_min_capacity"></a> [serverlessv2\_min\_capacity](#input\_serverlessv2\_min\_capacity) | Minimum capacity for an Aurora DB cluster in provisioned DB engine mode. The minimum capacity must be lesser than or equal to the maximum capacity. Valid capacity values are in a range of 0.5 up to 128 in steps of 0.5. | `number` | `1` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Whether to skip to create snapshot while delete the database | `bool` | `true` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this database from a snapshot | `string` | `null` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | Type of  storage for database | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of the DB tier subnet ids | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for database instance and cluster | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rds-endpoint"></a> [rds-endpoint](#output\_rds-endpoint) | RDS Database Endpoint Address |


## Authors
Module is maintained by [Jerin Rathnam](https://github.com/jerinrathnam).

**LinkedIn:**  _[Jerin Rathnam](https://www.linkedin.com/in/jerin-rathnam)_.

## License
Apache 2 Licensed. See [LICENSE](https://github.com/jerinrathnam/terraform-aws-rds/blob/main/LICENSE) for full details.