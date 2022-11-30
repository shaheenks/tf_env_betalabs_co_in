resource "google_service_account" "tf-access-sa-org-admin" {
  account_id = "tf-access-sa-org-admin"
  project = module.shared-services-project.project_id
}

resource "google_service_account" "tf-access-sa-env-admin" {
  account_id = "tf-access-sa-env-admin"
  project = module.shared-services-project.project_id
}

module "tf-access-sa-org-admin-iam" {
  source = "terraform-google-modules/iam/google//modules/service_accounts_iam"

  service_accounts = [google_service_account.tf-access-sa-org-admin.email]
  project          = module.shared-services-project.project_id
  mode             = "additive"
  bindings = {
    "roles/iam.serviceAccountTokenCreator" = [
      "group:gcp-organization-admins@betalabs.co.in",
      "user:shaheenks@betalabs.co.in"
    ]
  }
}

module "tf-access-sa-env-admin-iam" {
  source = "terraform-google-modules/iam/google//modules/service_accounts_iam"

  service_accounts = [google_service_account.tf-access-sa-env-admin.email]
  project          = module.shared-services-project.project_id
  mode             = "additive"
  bindings = {
    "roles/iam.serviceAccountTokenCreator" = [
      "group:gcp-devops@betalabs.co.in",
      "user:shaheenks@betalabs.co.in"
    ]
  }
}

module "tf-access-sa-org-iam" {
  source  = "terraform-google-modules/iam/google//modules/organizations_iam"
  version = "~> 7.4"

  organizations = [ var.org_id ]

  bindings = {

    "roles/resourcemanager.organizationAdmin" = [
      "serviceAccount:${google_service_account.tf-access-sa-org-admin.email}",
    ],
    "roles/resourcemanager.folderAdmin" = [
      "serviceAccount:${google_service_account.tf-access-sa-org-admin.email}",
    ],
    "roles/resourcemanager.projectCreator" = [
      "serviceAccount:${google_service_account.tf-access-sa-org-admin.email}",
    ],
    "roles/billing.admin" = [
      "serviceAccount:${google_service_account.tf-access-sa-org-admin.email}",
    ],
    "roles/iam.organizationRoleAdmin" = [
      "serviceAccount:${google_service_account.tf-access-sa-org-admin.email}",
    ],
    "roles/orgpolicy.policyAdmin" = [
      "serviceAccount:${google_service_account.tf-access-sa-org-admin.email}",
    ],
    "roles/logging.admin" = [
      "serviceAccount:${google_service_account.tf-access-sa-org-admin.email}",
    ],
    "roles/resourcemanager.folderEditor" = [
        "serviceAccount:${google_service_account.tf-access-sa-env-admin.email}",
    ],
     "roles/compute.networkAdmin" = [
      "serviceAccount:${google_service_account.tf-access-sa-env-admin.email}",
    ],
    "roles/compute.xpnAdmin" = [
      "serviceAccount:${google_service_account.tf-access-sa-env-admin.email}",
    ],
    "roles/compute.securityAdmin" = [
      "serviceAccount:${google_service_account.tf-access-sa-env-admin.email}",
    ],
    "roles/resourcemanager.folderViewer" = [
      "serviceAccount:${google_service_account.tf-access-sa-env-admin.email}",
    ],
    "roles/resourcemanager.projectDeleter" = [
      "serviceAccount:${google_service_account.tf-access-sa-env-admin.email}",
    ],
    "roles/resourcemanager.projectMover" = [
      "serviceAccount:${google_service_account.tf-access-sa-env-admin.email}",
    ],
    "roles/resourcemanager.projectDeleter" = [
      "serviceAccount:${google_service_account.tf-access-sa-env-admin.email}",
    ]
    "roles/owner" = [
      "serviceAccount:${google_service_account.tf-access-sa-env-admin.email}",
      "serviceAccount:${google_service_account.tf-access-sa-org-admin.email}"
    ]
  }
}

