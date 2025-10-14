# This block configures Terraform to use the Google Cloud provider.
provider "google" {
  project = "devops-task-project-475110" # <-- VERY IMPORTANT: REPLACE THIS
  region  = "us-central1"
}

# This block defines the GKE Kubernetes Cluster resource we want to create.
resource "google_container_cluster" "primary" {
  name     = "hello-world-cluster"
  location = "us-central1-c"

  # We'll start with a small, cost-effective cluster.
  initial_node_count = 1

  node_config {
    machine_type = "e2-small" # A good choice for simple apps.
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
