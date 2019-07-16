variable "gcp_cluster_name" {
    description = "google cloud cluster name"
    type ="string"
}

variable "node_count" {
    description = "node count for gcp cluster"
}

variable "location" {
    description = "location to deploy cluster" 
}

variable "gcp_admin_username" {
    description = "username for cluster authentication"
}

variable "gcp_admin_password" {
    description = "password for cluster authentication"
}

