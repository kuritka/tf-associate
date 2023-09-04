locals {
  common_annotations = {
    "kuritka.io/repo"     = "tf-associate"
    "kuritka.io/provider" = "k8s"
  }
}

module "cluster" {
  source  = "../../../modules/k8s"
  region  = var.region
  context = var.context
  annotations = merge(local.common_annotations, {
    "kuritka.io/environment" = var.environment,
    "kuritka.io/region"      = var.region
  })
}
