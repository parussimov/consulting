resource "google_compute_network" "this" {
  name                    = "main"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
  project                 = google_project.this.project_id

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}
