resource "google_project_service" "compute" {
  project = google_project.this.project_id
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  project = google_project.this.project_id
  service = "container.googleapis.com"

  depends_on = [google_project_service.compute]
}

resource "google_project_service" "monitoring" {
  project = google_project.this.project_id
  service = "monitoring.googleapis.com"

  depends_on = [google_project_service.compute]
}
