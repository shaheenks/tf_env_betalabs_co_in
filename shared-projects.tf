resource "google_folder" "common" {
  display_name = "Common"
  parent       = "organizations/${var.org_id}"
}

resource "google_folder" "workloads" {
  display_name = "Workloads"
  parent       = "organizations/${var.org_id}"
}

module "shared-services-env01" {
  source="terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name="shared-services-env01"
  org_id = var.org_id
  random_project_id = true
  folder_id=google_folder.common.name
  auto_create_network = false
  billing_account=var.billing_account
  default_service_account = "disable"
  svpc_host_project_id = module.vpc-host-common-env01.project_id
}

module "project-iam-bindings-001" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  projects = [module.shared-services-env01.project_id]
  mode="additive"

  bindings = {
    "roles/owner" = [
      "user:admin@betalabs.co.in"
    ]
  }
}

module "vpc-host-common-env01" {
  source="terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name="vpc-host-common-env01"
  org_id = var.org_id
  random_project_id = true
  folder_id=google_folder.common.name
  auto_create_network = false
  billing_account=var.billing_account
  default_service_account = "disable"
  enable_shared_vpc_host_project= true
}
