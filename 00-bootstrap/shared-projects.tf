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

# module "tf-backend-project-iam" {
#   source   = "terraform-google-modules/iam/google//modules/projects_iam"
#   projects = [module.shared-services-project.project_id]
#   mode="additive"

#   bindings = {
#     "roles/storage.admin" = [
#         "user:shaheenks@betalabs.co.in",
#         "user:admin@betalabs.co.in",
#         "group:gcp-devops@betalabs.co.in",
#         "group:gcp-developers@betalabs.co.in"
#     ]
#   }
# }

module "tf-backend-gcs-object-editor" {
    source = "terraform-google-modules/iam/google//modules/custom_role_iam"

    target_level         = "project"
    target_id            = module.shared-services-project.project_id
    role_id              = "tf_backend_gcs_object_editor"
    title                = "TF Backend GCS Object Editor"
    description          = "For TF backend operations on GCS"
    permissions          = ["storage.buckets.list", "storage.objects.get", "storage.objects.create","storage.objects.delete","storage.objects.update"]
    members              = [
        "user:shaheenks@betalabs.co.in",
        "user:admin@betalabs.co.in",
        "group:gcp-devops@betalabs.co.in",
        "group:gcp-developers@betalabs.co.in"
    ]
}
