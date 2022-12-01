locals {
  disable_vm_ip_forwarding_value = "FALSE"
  disable_service_account_creation_value = "FALSE"
  allowed_gcp_resources_value = []
  disable_automatic_iam_grants_for_default_sa_value = "FALSE"
  disable_vm_external_ip_value = "TRUE"
}
/*This list constraint defines the set of VM instances that can enable IP forwarding. 
By default, any VM can enable IP forwarding in any virtual network. 
VM instances must be specified in the form: under:organizations/ORGANIZATION_ID, under:folders/FOLDER_ID, 
under:projects/PROJECT_ID, or projects/PROJECT_ID/zones/ZONE/instances/INSTANCE-NAME. 
This constraint is not retroactive.
*/
resource "google_org_policy_policy" "disable_vm_ip_forwarding" {
  count = local.disable_vm_ip_forwarding_value == "TRUE" ? 1 : 0
  name="projects/${module.shared-services-project.project_id}/policies/compute.vmCanIpForward"
  parent="projects/${module.shared-services-project.project_id}"
  spec{
    rules{
      deny_all = local.disable_vm_ip_forwarding_value
    }
  }
}

/*
This boolean constraint disables the creation of service accounts where this constraint is set to `True`. 
By default, service accounts can be created by users based on their Cloud IAM roles and permissions
*/
resource "google_org_policy_policy" "disable_service_account_creation" {
  count = local.disable_service_account_creation_value == "TRUE" ? 1 : 0
  name="projects/${module.shared-services-project.project_id}/policies/iam.disableServiceAccountCreation"
  parent="projects/${module.shared-services-project.project_id}"
  spec{
    rules{
      enforce = local.disable_service_account_creation_value
    }
  }
}

/*
This constraint defines the set of Google Cloud resource services that can be used within an organization, 
folder, or project, such as compute.googleapis.com and storage.googleapis.com. 
By default, all Google Cloud resource services are allowed. 
For more information, see https://cloud.google.com/resource-manager/help/organization-policy/restricting-resources.
*/
resource "google_org_policy_policy" "allowed_gcp_resources" {
  count =  length(local.allowed_gcp_resources_value) > 1 ? 1 : 0
  name="projects/${module.shared-services-project.project_id}/policies/gcp.restrictServiceUsage"
  parent="projects/${module.shared-services-project.project_id}"
  spec{
    rules{
      values{
        allowed_values = local.allowed_gcp_resources_value
      }
    }
  }
}

/*
This boolean constraint, when enforced, prevents the default App Engine and Compute Engine service accounts that are 
created in your projects from being automatically granted any IAM role on the project when the accounts are created. 
By default, these service accounts automatically receive the Editor role when they are created.
*/
resource "google_org_policy_policy" "disable_automatic_iam_grants_for_default_sa" {
  count = local.disable_automatic_iam_grants_for_default_sa_value == "TRUE" ? 1 : 0
  name="projects/${module.shared-services-project.project_id}/policies/iam.automaticIamGrantsForDefaultServiceAccounts"
  parent="projects/${module.shared-services-project.project_id}"
  spec{
    rules{
      enforce = local.disable_automatic_iam_grants_for_default_sa_value
    }
  }
}

/*
This list constraint defines the set of Compute Engine VM instances that are allowed to use external IP addresses. 
By default, all VM instances are allowed to use external IP addresses. The allowed/denied list of VM instances must be 
identified by the VM instance name, in the form: projects/PROJECT_ID/zones/ZONE/instances/INSTANCE
*/
resource "google_org_policy_policy" "disable_vm_external_ip" {
  count = local.disable_vm_external_ip_value == "TRUE" ? 1 : 0
  name="projects/${module.shared-services-project.project_id}/policies/compute.vmExternalIpAccess"
  parent="projects/${module.shared-services-project.project_id}"
  spec{
    rules{
      deny_all = local.disable_vm_external_ip_value
    }
  }
}