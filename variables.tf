variable "region" {
  type        = string
  description = "Default region to deploy resources"
}

variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "db_instance_specs" {
  type        = string
  description = "SQL database instance type and size"
}

variable "machine_type" {
  type        = string
  description = "VM Instance Specs"
}

variable "db_password" {
  type        = string
  description = "PostgreSQL DB Password"
}

variable "db_instance_name" {
  type        = string
  description = "PostgreSQL DB Password"
}
