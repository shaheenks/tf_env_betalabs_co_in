module "logging-common-bl101-en001" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name       = "logging-common"
  project_id = "logging-common-bl101-en001"
  org_id     = var.org_id
  folder_id  = google_folder.common.name

  billing_account = var.billing_account
}

module "monitoring-dev-bl101-en001" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name       = "monitoring-dev"
  project_id = "monitoring-dev-bl101-en001"
  org_id     = var.org_id
  folder_id  = google_folder.common.name

  billing_account = var.billing_account
}

# module "monitoring-staging-bl101-en001" {
#   source  = "terraform-google-modules/project-factory/google"
#   version = "~> 12.0"

#   name       = "monitoring-staging"
#   project_id = "monitoring-staging-bl101-en001"
#   org_id     = var.org_id
#   folder_id  = google_folder.common.name

#   billing_account = var.billing_account
# }

# module "monitoring-prod-bl101-en001" {
#   source  = "terraform-google-modules/project-factory/google"
#   version = "~> 12.0"

#   name       = "monitoring-prod"
#   project_id = "monitoring-prod-bl101-en001"
#   org_id     = var.org_id
#   folder_id  = google_folder.common.name

#   billing_account = var.billing_account
# }

module "vpc-host-dev-bl101-en001" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 12.0"

  name       = "vpc-host-dev"
  project_id = "vpc-host-dev-bl101-en001"
  org_id     = var.org_id
  folder_id  = google_folder.common.name
  enable_shared_vpc_host_project = true

  billing_account = var.billing_account
}

# module "vpc-host-staging-bl101-en001" {
#   source  = "terraform-google-modules/project-factory/google"
#   version = "~> 12.0"

#   name       = "vpc-host-staging"
#   project_id = "vpc-host-staging-bl101-en001"
#   org_id     = var.org_id
#   folder_id  = google_folder.common.name
#   enable_shared_vpc_host_project = true

#   billing_account = var.billing_account
# }

# module "vpc-host-prod-bl101-en001" {
#   source  = "terraform-google-modules/project-factory/google"
#   version = "~> 12.0"

#   name       = "vpc-host-prod"
#   project_id = "vpc-host-prod-bl101-en001"
#   org_id     = var.org_id
#   folder_id  = google_folder.common.name
#   enable_shared_vpc_host_project = true

#   billing_account = var.billing_account
# }

resource "google_project" "tf-backend-common" {
  name="tf-backend-common"
  project_id = "tf-backend-common-bl101-en001"
  folder_id = google_folder.common.name
  
  skip_delete = true
  auto_create_network = false

  billing_account = var.billing_account
}

