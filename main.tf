module "network" {
  source = "./modules/network"

  network_name = "vpc-notesapp"
  public_subnets = [
    "10.100.0.0/21",
  ]
  private_subnets = [
    "10.100.8.0/21",
  ]
  public_subnet_suffix  = "public-project-notesapp"
  private_subnet_suffix = "private-project-notesapp"
  region                = var.region
}

module "database" {
  source = "./modules/database"

  network_id               = module.network.network_id
  cidr_block               = "10.100.32.0"
  private_ip_address_name  = "private-sql-network"
  cidr_block_prefix_length = 20
  region                   = var.region
  database_version         = "POSTGRES_14"
  home_ip_address          = "38.25.18.114"
  instance_name            = "notesapp-database-14"
  instance_specs           = var.db_instance_specs
}

resource "google_vpc_access_connector" "connector" {
  name          = "vpc-serverless-connection"
  ip_cidr_range = "10.100.64.0/28"
  network       = module.network.network_name
}

resource "google_cloud_run_service" "default" {
  location = var.region
  name     = "notes-app"

  template {
    spec {
      container_concurrency = 80
      service_account_name  = "213254863756-compute@developer.gserviceaccount.com"
      timeout_seconds       = 300

      containers {
        image = "us-central1-docker.pkg.dev/agile-terra-359116/notes-app-repo/notes-app:latest"

        env {
          name  = "DATABASE_URL"
          value = "postgresql://notes_user:${var.db_password}@${module.database.sql_private_ip_address}:5432/notesapp?schema=public"
        }

        ports {
          container_port = 8080
          name           = "http1"
        }

        resources {
          limits = {
            "cpu"    = "1000m"
            "memory" = "512Mi"
          }
        }
      }
    }
  }

  traffic {
    latest_revision = true
    percent         = 100
  }
}

resource "null_resource" "initialize_database" {
  provisioner "local-exec" {
    
  }
}