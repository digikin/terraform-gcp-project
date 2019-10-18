##
## Edit this for a non-production environment
##

provider "google" {

}

variable "project" { }

locals {
    api_list = [
        "appengine.googleapis.com",
        "appengineflex.googleapis.com",
        "bigquery-json.googleapis.com",
        "bigquerystorage.googleapis.com",
        "cloudbuild.googleapis.com",
        "cloudfunctions.googleapis.com",
        "compute.googleapis.com",
        "container.googleapis.com",
        "containerregistry.googleapis.com",
        "deploymentmanager.googleapis.com",
        "iam.googleapis.com",
        "iamcredentials.googleapis.com",
        "logging.googleapis.com",
        "monitoring.googleapis.com",
        "oslogin.googleapis.com",
        "pubsub.googleapis.com",
        "replicapool.googleapis.com",
        "replicapoolupdater.googleapis.com",
        "resourceviews.googleapis.com",
        "servicenetworking.googleapis.com",
        "serviceusage.googleapis.com",
        "storage-api.googleapis.com",
        "storage-component.googleapis.com",
    ]
}

resource "google_project_service" "project_services" {
  project = "${var.project}"
  count = "${length(local.api_list)}"
  service = "${element(local.api_list, count.index)}"
}
