resource "google_compute_address" "nat" {
  name         = "nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  project      = google_project.this.project_id

  depends_on = [google_project_service.compute]
}

resource "google_compute_router_nat" "this" {
  name    = "main"
  router  = google_compute_router.this.name
  project = google_project.this.project_id
  region  = local.region

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.private.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.nat.self_link]
}
