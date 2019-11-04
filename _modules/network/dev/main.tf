##
## Edit this for a development environment
##
variable "gcp_credentials" {}
provider "google" {
  credentials = var.gcp_credentials
}

locals {
  subnet_data = {
      "us-east1" = "10.148.0.0/20"
      "us-east4" = "10.158.0.0/20"
      "us-central1" = "10.128.0.0/20"
      "us-west1" = "10.138.0.0/20"
      "us-west2" = "10.168.0.0/20"
  }
}

resource "google_compute_subnetwork" "default" {
  for_each = local.subnet_data
  project = "${var.project}"
  name = "${var.name}"
  ip_cidr_range = each.value
  region = each.key
  network = "${google_compute_network.default.self_link}"
}

resource "google_compute_network" "default" {
    project = "${var.project}"  
    name = "default-vpc"
}


