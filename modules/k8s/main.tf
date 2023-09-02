resource "kubernetes_namespace" "us_east_1c" {
  metadata {
    annotations = var.annotations
    labels      = {}
    name        = "${var.region}-1c"
  }
}

resource "kubernetes_namespace" "us_east_1b" {
  metadata {
    annotations = var.annotations
    labels      = {}
    name        = "${var.region}-1b"
  }
}

resource "kubernetes_namespace" "us_east_1a" {
  metadata {
    annotations = var.annotations
    labels      = {}
    name        = "${var.region}-1a"
  }
}
