provider "google" {
    credentials = "${file("mstack-k8s-e6e5a49e04fb.json")}"
    project = "mStack-k8s"
    region = "asia-south1-a"
}

