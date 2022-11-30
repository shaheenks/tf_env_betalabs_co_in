module "shared-services-project" {
  source="terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name="shared-services-env01"
  random_project_id = true
  auto_create_network = false
  enable_shared_vpc_host_project= true

  # budget_amount = 5000

  org_id = var.org_id
  folder_id=google_folder.common.name
  billing_account=var.billing_account

  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "serviceusage.googleapis.com",
    "orgpolicy.googleapis.com",
    "billingbudgets.googleapis.com"
  ]
}

# module "tf-backend-project-iam" {
#   source   = "terraform-google-modules/iam/google//modules/projects_iam"
#   projects = [module.shared-services-project.project_id]
#   mode="additive"

#   bindings = {
#     "roles/serviceusage.serviceUsageConsumer" = [
#       "serviceAccount:${google_service_account.tf-access-sa-org-admin.email}"
#     ]
#   }
# }

module "tf-backend-gcs-object-editor" {
    source = "terraform-google-modules/iam/google//modules/custom_role_iam"

    target_level         = "project"
    target_id            = module.shared-services-project.project_id
    role_id              = "tf_backend_gcs_object_editor"
    title                = "Terraform State Administrator"
    description          = "For TF backend operations on GCS"
    permissions          = ["storage.buckets.list", "storage.objects.list", "storage.buckets.get", "storage.objects.create","storage.objects.delete","storage.objects.update"]
    members              = [
        "user:shaheenks@betalabs.co.in",
        "serviceAccount:${google_service_account.tf-access-sa-org-admin.email}",
        "serviceAccount:${google_service_account.tf-access-sa-env-admin.email}"
    ]
}
