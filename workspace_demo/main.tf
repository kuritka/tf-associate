locals {
  ctx = "kubernetes-admin@kubernetes"
}


resource "kubernetes_namespace" "workspace" {
  metadata {
    name = "workspace"
    annotations = {
      "name"    = "workspace"
      "context" = var.context
    }
  }
}

resource "kubernetes_config_map" cm {
  count = 3
  metadata {
    name = "cm-${count.index}"
    namespace = kubernetes_namespace.workspace.metadata.0.name
    annotations = {
      "name"    = "cm-${count.index}"
      "context" = var.context
    }
  }
  data = {
    "context" = local.ctx
    "subnets" = "[${join(",",cidrsubnets("10.10.0.0/16",8, count.index+1))}]"
  }
}