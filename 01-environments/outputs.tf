output "development-folder" {
  description = "Folder for development resources."
  value = google_folder.development-folder.name
}

output "production-folder" {
  description = "Folder for development resources."
  value = google_folder.production-folder.name
}

output "playground-dev-project" {
  description = "Folder for development resources."
  value = module.playground-dev-project.project_id
}