resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
  project    = google_project.this.project_id
}

resource "google_project_iam_member" "collector" {
  project = local.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.kubernetes.email}"
}

resource "google_container_node_pool" "general" {
  name       = "general"
  cluster    = google_container_cluster.this.id
  project    = google_project.this.project_id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    spot         = false
    machine_type = "e2-medium"

    labels = {
      role = "general"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
