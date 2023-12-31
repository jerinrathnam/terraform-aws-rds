
## Usage

### Create Aurora PostgreSQL Cluster

```
  module "rds" {
    source = "../../"

    engine_type             = "aurora-postgresql"
    engine_version          = "14.5"
    parameter_group_family  = "aurora-postgresql14"
    master_username         = var.master_username
    master_password         = var.master_password
    name                    = var.db_name
    subnet_ids              = var.subnet_ids
    security_group_ids      = [var.security_group_id]
  }
```

## Description

This is an exapmle script for create an Aurora PostgreSQL RDS database cluster.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds"></a> [rds](#module\_rds) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name needs to be create | `string` | n/a | yes |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | Master password for the username of the Database cluster | `string` | n/a | yes |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | Master username for the Database cluster | `string` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | Security group ID for the Database | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet ids for the Database | `list(string)` | n/a | yes |

## Outputs

No outputs.
