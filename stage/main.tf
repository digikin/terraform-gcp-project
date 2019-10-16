provider "google" {
  region = "${var.region}"
}

provider "google-beta" {

}


resource "google_project" "project" {
  name                = "${var.project_name}"
  org_id              = "955234961274"
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
  source  = "../modules/services/"
  project = "${data.google_project_services.project.project}"

}

module "network_services" {
  source  = "../modules/network/"
  project = "${data.google_project_services.project.project}"
  name    = "${data.google_project_services.project.project}"
}




