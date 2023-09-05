
resource "kubernetes_namespace" "workspace" {
  metadata {
    name = "workspace"
    annotations = {
      "name"    = "workspace"
      "context" = var.context
    }
  }
}