resource "google_service_account" "gmp_prometheus" {
  account_id = "gmp-prometheus-test"
  project    = google_project.this.project_id
}

resource "google_project_iam_member" "gmp_prometheus" {
  project = local.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.gmp_prometheus.email}"
}

resource "google_service_account_iam_member" "gmp_prometheus" {
  service_account_id = google_service_account.gmp_prometheus.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${local.project_id}.svc.id.goog[gmp-monitoring/my-gmp-prometheus]"

  depends_on = [google_container_cluster.this]
}
