resource "google_container_cluster" "this" {
  name                     = "main"
  location                 = local.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.this.self_link
  subnetwork               = google_compute_subnetwork.private.self_link
  project                  = google_project.this.project_id
  networking_mode          = "VPC_NATIVE"

  deletion_protection = false

  monitoring_config {
    managed_prometheus {
      enabled = true
    }

    # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#enable_components
    enable_components = ["SYSTEM_COMPONENTS", "APISERVER"]
  }

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${google_project.this.project_id}.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}
