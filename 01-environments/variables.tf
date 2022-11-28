variable "common-folder" {
  description = "Folder for common resources."
  type        = string
  default = "folders/996766225301"
}

variable "workloads-folder" {
  description = "Folder for workload resources."
  type        = string
  default = "folders/416641803993"
}

variable "shared-services-project" {
  description = "Project hosting shared service resources."
  type        = string
  default = "shared-services-env01-7fca"
}

variable "billing_account" {
  description = "The ID of the billing account to associate projects with"
  type        = string
  default     = "0190EF-FB6B3C-A5E6DA"
}

variable "org_id" {
  description = "The organization id for the associated resources"
  type        = string
  default     = "682729577898"
}
