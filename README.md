## Terraform folder structure to create a Google Cloud project
```
├── _modules
│   ├── network
│   │   ├── dev
│   │   │   └── main.tf
│   │   ├── nonprod
│   │   │   └── main.tf
│   │   └── prod
│   │       └── main.tf
│   └── services
│       ├── dev
│       │   └── main.tf
│       ├── nonprod
│       │   └── main.tf
│       └── prod
│           └── main.tf
├── dev
│   ├── main.tf
│   └── vars.tf
├── nonprod
│   ├── main.tf
│   └── vars.tf
├── prod
    ├── main.tf
    └── vars.tf
```

### Features:

This is a simple main.tf that has separated modules for activating APIs and subnetworks for a new project.  This terraform skeleton also shows how to benifit from breaking down sections into modules plus uses examples on how to execute simple logic like `count.index` and `for_each` to keep the terraform code minimal. The goal of this is to create multi environment deployment from a single repo.  

1. The network module uses a `for_each` loop
```
resource "google_compute_subnetwork" "default" {
  for_each = local.subnet_data
  project = "${var.project}"
  name = "${var.name}"
  ip_cidr_range = each.value
  region = each.key
  network = "${google_compute_network.default.self_link}"
}
```
2. The services module activates a `count.index` parameter
```
resource "google_project_service" "project_services" {
  project = "${var.project}"
  count = "${length(local.api_list)}"
  service = "${element(local.api_list, count.index)}"
}
```
### Objectives:

Generally speaking as each environment goes up (dev -> nonprod -> prod) security for a project becomes more strict.  To achieve this change the environments main.tf modules source to point at the corresponding module environments folder.
`_modules/services/dev/main.tf` into `_modules/services/nonprod/main.tf`  
then reduce the amout of API's that are enabled or remove subnets upon project creation.  

Inside the modules folder `/_modules/services/nonprod/main.tf` alter the list of APIs that get enabled.  The same goes for `/_modules/services/prod/main.tf` file.

In each environment the only part that changes per environment main.tf is the **source** part of the module. 
  
#### `./dev/main.tf`
```
module "api_services" {
  source  = "../_modules/services/dev/"
  project = "${data.google_project_services.project.project}"
}
```
#### `./nonprod/main.tf`
```
module "api_services" {
  source  = "../_modules/services/nonprod/"
  project = "${data.google_project_services.project.project}"
}
```

### Execution:
The commands are the same but to deploy a specific environment the `terraform plan` and `terraform apply` must contain the folder.  
For example:  
To deploy a **dev** environment - (from the root directory)
```
terraform init /dev
terraform plan /dev
terraform apply /dev
```  
To deploy a **nonprod** environment - (from the root directory)
```
terraform init /nonprod
terraform plan /nonprod
terraform apply /nonprod
```

