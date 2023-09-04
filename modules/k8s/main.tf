resource "kubernetes_namespace" "one" {
  metadata {
    annotations = var.annotations
    labels      = {}
    name        = "${var.region}-1c"
  }
}

resource "kubernetes_namespace" "two" {
  metadata {
    annotations = var.annotations
    labels      = {}
    name        = "${var.region}-1b"
  }
}

resource "kubernetes_namespace" "three" {
  metadata {
    annotations = var.annotations
    labels      = {}
    name        = "${var.region}-1a"
  }
}
