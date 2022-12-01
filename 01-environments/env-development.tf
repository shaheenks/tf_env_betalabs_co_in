resource "google_folder" "development-folder" {
  display_name = "Development"
  parent       = var.workloads-folder
}

module "playground-dev-project" {
  source="terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name="playground-dev-env01"
  random_project_id = true
  auto_create_network = false
  default_service_account = "disable"
  svpc_host_project_id = var.shared-services-project

  # budget_amount = 1000

  org_id = var.org_id
  folder_id=google_folder.development-folder.name
  billing_account=var.billing_account

  shared_vpc_subnets = [
  "https://www.googleapis.com/compute/v1/projects/shared-services-env01-7fca/regions/asia-south1/subnetworks/common-asia-s1",
  "https://www.googleapis.com/compute/v1/projects/shared-services-env01-7fca/regions/asia-southeast1/subnetworks/common-asia-se1",
  "https://www.googleapis.com/compute/v1/projects/shared-services-env01-7fca/regions/us-central1/subnetworks/common-us-c1",
]

  activate_apis = [
    # "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    # "iam.googleapis.com",
    # "serviceusage.googleapis.com",
    # "billingbudgets.googleapis.com",
    "container.googleapis.com"
  ]
}

module "playground-dev-project-iam" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  projects = [ module.playground-dev-project.project_id ]
  mode     = "additive"

  bindings = {
    "roles/owner" = [
      "user:shaheenks@betalabs.co.in",
      "user:admin@betalabs.co.in"
    ]
  }
}