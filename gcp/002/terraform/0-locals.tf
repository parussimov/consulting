resource "random_integer" "int" {
  min = 100
  max = 1000000
}

locals {
  region          = "us-central1"
  zone            = "us-central1-a"
  org_id          = "206720471760"
  billing_account = "01FDA3-9697F3-6F05B8"
  env             = "dev"
  project_name    = "k8s-${local.env}"
  project_id      = "${local.project_name}-${random_integer.int.result}"
}
