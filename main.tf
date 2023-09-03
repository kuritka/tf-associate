locals {
  common_annotations = {
    "kuritka.io/repo"     = "tf-associate"
    "kuritka.io/provider" = "k8s"
  }
}

module "cluster" {
  source = "./modules/k8s"
  region = var.region
  #  context                = var.context
  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
  annotations = merge(local.common_annotations, {
    "kuritka.io/environment" = var.environment,
    "kuritka.io/region"      = var.region
  })
}
