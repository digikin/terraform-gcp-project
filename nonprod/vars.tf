variable "region" {
  description = "GCP region"
  default = ""
}

variable "org_id" {
  description = "Org ID number"
  default = ""
}
variable "project_name" {
  description = "Project name"
  default = ""
}

variable "folder_id" {
  description = "Where the project will be located. 0 is under the main org."
  default = ""
}

variable "billing_account" {
  description = "To find this out run 'gcloud alpha billing accounts list'"
  default = ""
}



