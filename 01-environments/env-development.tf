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
}

module "playground-dev-project-iam" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  projects = [ module.playground-dev-project.project_id ]
  mode     = "additive"

  bindings = {
    "roles/owner" = [
      "user:shaheenks@betalabs.co.in"
    ],
    "roles/compute.networkAdmin" = [
      "group:gcp-developers@betalabs.co.in",
    ]
    "roles/appengine.appAdmin" = [
      "group:gcp-developers@betalabs.co.in",
    ]
  }
}