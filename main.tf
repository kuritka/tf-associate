locals {
  common_annotations = {
    "kuritka.io/repo"     = "tf-associate"
    "kuritka.io/provider" = "k8s"
  }
}

resource "kubernetes_namespace" "us_east_1c" {
  metadata {
    annotations = local.common_annotations
    labels      = {}
    name        = "us-east-1c"
  }
}

resource "kubernetes_namespace" "us_east_1b" {
  metadata {
    annotations = local.common_annotations
    labels      = {}
    name        = "us-east-1b"
  }
}

resource "kubernetes_namespace" "us_east_1a" {
  metadata {
    annotations = local.common_annotations
    labels      = {}
    name        = "us-east-1a"
  }
}
