provider "google" {
  region = "${var.region}"
  credentials = "${var.gcp_credentials}"
}

provider "google-beta" {
}


resource "google_project" "project" {
  name                = "${var.project_name}"
  org_id              = "${var.org_id}"
  project_id          = "${var.project_name}"
  billing_account     = "${var.billing_account}"
  auto_create_network = "false"
}

data "google_project_services" "project" {
  project = "${google_project.project.project_id}"
}

output "project_number" {
  value = "${data.google_project_services.project.project}"
}



module "api_services" {
  source  = "../_modules/services/dev/"
  project = "${data.google_project_services.project.project}"
}

module "network_services" {
  source  = "../_modules/network/dev/"
  project = "${data.google_project_services.project.project}"
  name    = "${data.google_project_services.project.project}"
}




