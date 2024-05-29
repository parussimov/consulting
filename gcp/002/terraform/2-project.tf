resource "google_project" "this" {
  name                = local.project_name
  project_id          = local.project_id
  billing_account     = local.billing_account
  org_id              = local.org_id
  auto_create_network = false
}
