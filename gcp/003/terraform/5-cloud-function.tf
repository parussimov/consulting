data "archive_file" "analytics" {
  type = "zip"

  source_dir  = "../${path.module}/functions/gcp-analytics/"
  output_path = "../${path.module}/functions/gcp-analytics.zip"
}

resource "google_storage_bucket_object" "analytics" {
  name           = "gcp-analytics.zip"
  bucket         = google_storage_bucket.functions.name
  source         = data.archive_file.analytics.output_path
  detect_md5hash = filemd5(data.archive_file.analytics.output_path)
}

resource "google_service_account" "analytics" {
  account_id = "analytics"
}

resource "google_cloudfunctions2_function" "analytics" {
  name     = "analytics"
  location = local.region

  build_config {
    runtime     = "python312"
    entry_point = "hello_http"
    source {
      storage_source {
        bucket     = google_storage_bucket.functions.name
        object     = google_storage_bucket_object.analytics.name
        generation = google_storage_bucket_object.analytics.generation
      }
    }
  }

  service_config {
    available_memory      = "512Mi"
    timeout_seconds       = 30
    max_instance_count    = 10
    service_account_email = google_service_account.analytics.email
    environment_variables = {
      BUCKET_NAME = google_storage_bucket.images.id
    }
  }

  depends_on = [
    google_project_service.cloudfunctions,
    google_project_service.run,
    google_project_service.artifactregistry,
    google_project_service.cloudbuild,
  ]
}

# Who can invoke the function?
# Allow public access or use a specific service account/user as a member.
resource "google_cloud_run_service_iam_member" "analytics" {
  project  = google_cloudfunctions2_function.analytics.project
  location = google_cloudfunctions2_function.analytics.location
  service  = google_cloudfunctions2_function.analytics.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Permissions that the cloud function has.
resource "google_project_iam_member" "storage" {
  project = google_cloudfunctions2_function.analytics.project
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.analytics.email}"
}

# Another method to grant permissions to a GS bucket.
# resource "google_storage_bucket_iam_member" "storage" {
#   bucket = google_storage_bucket.images.name
#   role   = "roles/storage.admin"
#   member = "serviceAccount:${google_service_account.analytics.email}"
# }

output "gcp_analytics_url" {
  value = google_cloudfunctions2_function.analytics.service_config[0].uri
}
