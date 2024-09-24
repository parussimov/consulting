resource "google_project_service" "cloudfunctions" {
  project = google_project.this.project_id
  service = "cloudfunctions.googleapis.com"
}

resource "google_project_service" "artifactregistry" {
  project = google_project.this.project_id
  service = "artifactregistry.googleapis.com"
}

resource "google_project_service" "cloudbuild" {
  project = google_project.this.project_id
  service = "cloudbuild.googleapis.com"
}

resource "google_project_service" "run" {
  project = google_project.this.project_id
  service = "run.googleapis.com"
}

resource "google_project_service" "logging" {
  project = google_project.this.project_id
  service = "logging.googleapis.com"
}

resource "google_project_service" "pubsub" {
  project = google_project.this.project_id
  service = "pubsub.googleapis.com"
}
