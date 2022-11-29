# resource "google_org_policy_policy" "disable_vm_external_ip" {
# #   count = var.disable_vm_external_ip_value == "TRUE" ? 1 : 0
#   name="organizations/${var.org_id}/policies/compute.vmExternalIpAccess"
#   parent="organizations/${var.org_id}"
#   spec{
#     rules{
#       deny_all = false
#     }
#   }
# }