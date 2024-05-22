resource "google_compute_router" "this" {
  name    = "main"
  region  = local.region
  network = google_compute_network.this.id
  project = google_project.this.project_id
}
