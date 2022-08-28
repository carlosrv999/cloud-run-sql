terraform {
  required_version = ">= 1.2.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.33.0"
    }
  }
}
