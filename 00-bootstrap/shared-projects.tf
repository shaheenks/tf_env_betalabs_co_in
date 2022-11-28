module "shared-services-project" {
  source="terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name="shared-services-env01"
  random_project_id = true
  auto_create_network = false
  default_service_account = "disable"
  enable_shared_vpc_host_project= true

  org_id = var.org_id
  folder_id=google_folder.common.name
  billing_account=var.billing_account
}

module "tf-backend-project-iam" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  projects = [module.shared-services-project.project_id]
  mode="additive"

  bindings = {
    "roles/owner" = [
      "user:admin@betalabs.co.in"
    ]

    "roles/storage.objectAdmin" = [
        "user:shaheenks@betalabs.co.in"
    ]
  }
}
