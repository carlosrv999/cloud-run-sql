output "sql_private_ip_address" {
  value = module.database.sql_private_ip_address
}

output "sql_public_ip_address" {
  value = module.database.sql_public_ip_address
}

output "cloud_run_url" {
  value = google_cloud_run_service.default.status[0].url
}
