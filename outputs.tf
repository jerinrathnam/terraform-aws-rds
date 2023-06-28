output "rds-endpoint" {
  value       = var.create_cluster ? aws_rds_cluster.this[0].endpoint : aws_db_instance.this[0].address
  description = "RDS Database Endpoint Address"
}