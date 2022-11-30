output "tf-backend-gcs" {
  description = "Bucket used for storing terraform state."
  value = google_storage_bucket.tf-backend-gcs.url
}

output "common-folder" {
  description = "Folder for common resources."
  value = google_folder.common.name
}

output "workloads-folder" {
  description = "Folder for workload resources."
  value = google_folder.workloads.name
}

output "shared-services-project" {
  description = "Project hosting shared service resources."
  value = module.shared-services-project.project_id
}

output "tf-access-sa-org-admin" {
  description="Email ID of org-admin service account."
  value = google_service_account.tf-access-sa-org-admin.email
}

output "tf-access-sa-env-admin" {
  description="Email ID of env-admin service account."
  value = google_service_account.tf-access-sa-env-admin.email
}