resource "google_folder" "common" {
  display_name = "Common"
  parent       = "organizations/${var.org_id}"
}

resource "google_folder" "workloads" {
  display_name = "Workloads"
  parent       = "organizations/${var.org_id}"
}