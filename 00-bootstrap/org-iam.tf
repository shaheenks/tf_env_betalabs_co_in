# Organization Level Admin Groups for different personas.
module "org-iam-folder-viewers" {
  source  = "terraform-google-modules/iam/google//modules/organizations_iam"
  version = "~> 7.4"

  organizations = ["682729577898"]

  bindings = {
    # Folder Viewer

    "roles/resourcemanager.folderViewer" = [
      "group:gcp-devops@betalabs.co.in",
      "group:gcp-developers@betalabs.co.in"
    ]
  }
}

module "org-iam-gcp-organization-admins" {
  source  = "terraform-google-modules/iam/google//modules/organizations_iam"
  version = "~> 7.4"

  organizations = ["682729577898"]

  bindings = {
        #  gcp-organization-admin roles at Organization level

        #  Organization Administrator
        #  Folder Admin
        #  Project Creator
        #  Billing Account User
        #  Organization Role Administrator
        #  Organization Policy Administrator
        #  Security Center Admin
        #  Support Account Administrator
    "roles/resourcemanager.organizationAdmin" = [
      "group:gcp-organization-admins@betalabs.co.in",
    ]

    "roles/resourcemanager.folderAdmin" = [
      "group:gcp-organization-admins@betalabs.co.in",
    ]

    "roles/resourcemanager.projectCreator" = [
      "group:gcp-organization-admins@betalabs.co.in",
    ]

    "roles/billing.user" = [
      "group:gcp-organization-admins@betalabs.co.in",
    ]

    "roles/iam.organizationRoleAdmin" = [
      "group:gcp-organization-admins@betalabs.co.in",
    ]

    "roles/orgpolicy.policyAdmin" = [
      "group:gcp-organization-admins@betalabs.co.in",
      "group:gcp-security-admins@betalabs.co.in"
    ]

    "roles/securitycenter.admin" = [
      "group:gcp-organization-admins@betalabs.co.in",
      "group:gcp-security-admins@betalabs.co.in"
    ]

    "roles/cloudsupport.admin" = [
      "group:gcp-organization-admins@betalabs.co.in",
    ]
  }
}

module "org-iam-gcp-security-admins" {
  source  = "terraform-google-modules/iam/google//modules/organizations_iam"
  version = "~> 7.4"

  organizations = ["682729577898"]

  bindings = {
        
    #gcp-security-admins

    # Organization Policy Administrator
    # Security Center Admin
    # Security Reviewer
    # Organization Role Viewer
    # Folder IAM Admin
    # Private Logs Viewer
    # Logs Configuration Writer
    # Kubernetes Engine Viewer
    # Compute Viewer

    "roles/orgpolicy.policyAdmin" = [
      "group:gcp-security-admins@betalabs.co.in"
    ]

    "roles/securitycenter.admin" = [
      "group:gcp-security-admins@betalabs.co.in"
    ]

    "roles/iam.securityReviewer" = [
      "group:gcp-security-admins@betalabs.co.in"
    ]

    "roles/iam.organizationRoleViewer" = [
      "group:gcp-security-admins@betalabs.co.in"
    ]

    "roles/resourcemanager.folderIamAdmin" = [
      "group:gcp-security-admins@betalabs.co.in"
    ]

    "roles/logging.privateLogViewer" = [
      "group:gcp-security-admins@betalabs.co.in"
    ]

    "roles/logging.configWriter" = [
      "group:gcp-security-admins@betalabs.co.in"
    ]

    "roles/container.viewer" = [
      "group:gcp-security-admins@betalabs.co.in"
    ]

    "roles/compute.viewer" = [
      "group:gcp-security-admins@betalabs.co.in"
    ]
  }
}

module "org-iam-gcp-billing-admins" {
  source  = "terraform-google-modules/iam/google//modules/organizations_iam"
  version = "~> 7.4"

  organizations = ["682729577898"]

  bindings = {
  
    # gcp-billing-admins roles at Organization level.

    # Billing Account Administrator
    # Billing Account Creator
    # Organization Viewer

    "roles/billing.admin" = [
      "group:gcp-billing-admins@betalabs.co.in",
    ]

    "roles/billing.creator" = [
      "group:gcp-billing-admins@betalabs.co.in",
    ]

    "roles/resourcemanager.organizationViewer" = [
      "group:gcp-billing-admins@betalabs.co.in",
    ]
    
  }
}

module "org-iam-gcp-network-admins" {
  source  = "terraform-google-modules/iam/google//modules/organizations_iam"
  version = "~> 7.4"

  organizations = ["682729577898"]

  bindings = {
  
    # gcp-network-admins

    # Compute Network Admin
    # Compute Shared VPC Admin
    # Compute Security Admin
    # Folder Viewer

    "roles/compute.networkAdmin" = [
      "group:gcp-network-admins@betalabs.co.in"
    ]

    "roles/compute.xpnAdmin" = [
      "group:gcp-network-admins@betalabs.co.in"
    ]

    "roles/compute.securityAdmin" = [
      "group:gcp-network-admins@betalabs.co.in"
    ]

    "roles/resourcemanager.folderViewer" = [
      "group:gcp-network-admins@betalabs.co.in"
    ]
    
  }
}

module "org-iam-gcp-logging-admins" {
  source  = "terraform-google-modules/iam/google//modules/organizations_iam"
  version = "~> 7.4"

  organizations = ["682729577898"]

  bindings = {
  
    #gcp-logging-admin

    # Logging Admin

    "roles/logging.admin" = [
      "group:gcp-logging-admins@betalabs.co.in"
    ]
    
  }
}

module "org-iam-gcp-monitoring-admins" {
  source  = "terraform-google-modules/iam/google//modules/organizations_iam"
  version = "~> 7.4"

  organizations = ["682729577898"]

  bindings = {
  
    #gcp-monitoring-admins

    # Monitoring Admin

    "roles/monitoring.admin" = [
      "group:gcp-monitoring-admins@betalabs.co.in"
    ]
    
  }
}