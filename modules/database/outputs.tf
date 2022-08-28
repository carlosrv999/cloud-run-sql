output "sql_private_ip_address" {
  value = google_sql_database_instance.default.private_ip_address
}

output "sql_public_ip_address" {
  value = google_sql_database_instance.default.public_ip_address
}

output "instance_name" {
  value = google_sql_database_instance.default.name
}
