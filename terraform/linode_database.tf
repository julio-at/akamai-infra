resource "linode_database_postgresql" "ssi-walt-id-login-database" {
  label     = "main-database-cluster"
  engine_id = "postgresql/12.12"
  region    = var.linode_region
  type      = "g6-nanode-1"

  allow_list = var.linode_database_allow_list
}

resource "null_resource" "create-database" {
  provisioner "local-exec" {
    command = <<EOT
PGPASSWORD=${linode_database_postgresql.ssi-walt-id-login-database.root_password} \
psql -h ${linode_database_postgresql.ssi-walt-id-login-database.host_primary} \
-U ${linode_database_postgresql.ssi-walt-id-login-database.root_username} \
-d postgres \
-c "CREATE DATABASE nftmeta;"
EOT

    interpreter = ["bash", "-c"]
  }

  depends_on = [linode_database_postgresql.ssi-walt-id-login-database]
}

resource "null_resource" "restore-database" {
  provisioner "local-exec" {
    command = <<EOT
PGPASSWORD=${linode_database_postgresql.ssi-walt-id-login-database.root_password} \
psql -h ${linode_database_postgresql.ssi-walt-id-login-database.host_primary} \
-U ${linode_database_postgresql.ssi-walt-id-login-database.root_username} \
-d ${var.linode_database_name} -f ${path.module}/files/nftmeta.sql
EOT

    interpreter = ["bash", "-c"]
  }

  depends_on = [null_resource.create-database]
}

locals {
  database_host     = linode_database_postgresql.ssi-walt-id-login-database.host_primary
  database_port     = linode_database_postgresql.ssi-walt-id-login-database.port
  database_username = linode_database_postgresql.ssi-walt-id-login-database.root_username
  database_password = linode_database_postgresql.ssi-walt-id-login-database.root_password
  database_name     = var.linode_database_name
}

output "database_host" {
  value = linode_database_postgresql.ssi-walt-id-login-database.host_primary
}

output "database_port" {
  value = linode_database_postgresql.ssi-walt-id-login-database.port
}

output "database_username" {
  value     = linode_database_postgresql.ssi-walt-id-login-database.root_username
  sensitive = true
}

output "database_password" {
  value     = linode_database_postgresql.ssi-walt-id-login-database.root_password
  sensitive = true
}

output "database_name" {
  value = var.linode_database_name
}
