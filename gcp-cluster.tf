resource "google_container_cluster" "gcp_cluster"{
    
    name = "${var.gcp_cluster_name}"
    location = "${var.location}"
    initial_node_count = "${var.node_count}"

    master_auth{
        username = "${var.gcp_admin_username}"
        password = "${var.gcp_admin_password}"

        client_certificate_config{
            issue_client_certificate = false
        }
    }

    node_config {
        oauth_scopes = [
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/monitoring",
        ]

        labels = {
            purpose = "Lab test"
        }
    }
}