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