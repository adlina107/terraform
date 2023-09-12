# Scenario: Provision a C3 instance on sole tenant using terraform on Google Cloud Platform (GCP)
# Create a terraform configuration file and name it as main.tf
# Reference: https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build 

data "google_compute_network" "vpc-network" {
  name    = "vpc-network"
  project = "test-project"
}

data "google_compute_subnetwork" "subnet-name" {
  name    = "subnet-name"
  project = "test-project"
  region  = "asia-southeast1"
}

resource "google_compute_node_template" "template" {
  name      = "c3-test-2"
  region    = "asia-southeast1"
  node_type = "c3-node-176-352"
}

# Create a node group
resource "google_compute_node_group" "nodes" {
  name        = "c3-soletenant-grp"
  zone        = "asia-southeast1-b"
  description = "example of C3 google_compute_node_group for Terraform Google Provider"

  size          = 2
  node_template = google_compute_node_template.template.id
}
