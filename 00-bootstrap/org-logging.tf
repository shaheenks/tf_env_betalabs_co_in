module "logsink-682729577898-logbucketsink" {
  source  = "terraform-google-modules/log-export/google"
  version = "~> 7.3.0"

  destination_uri      = module.betalabs-co-in-logging-destination.destination_uri
  log_sink_name        = "682729577898-logbucketsink"
  parent_resource_id   = var.org_id
  parent_resource_type = "organization"
  include_children     = true
}

module "betalabs-co-in-logging-destination" {
  source  = "terraform-google-modules/log-export/google//modules/logbucket"
  version = "~> 7.4.1"

  project_id               = module.shared-services-project.project_id
  name                     = "betalabs-co-in-logging"
  location                 = "global"
  retention_days           = 365
  log_sink_writer_identity = module.logsink-682729577898-logbucketsink.writer_identity
}