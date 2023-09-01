# TerraformAssociate


## 1 Import command , Import Block

- https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace

```shell
kubectl create ns us-east-1a
kubectl create ns us-east-1b
kubectl create ns us-east-1c
```

```tf
# import.tf
# terraform requires snake_case for the resource name
import {
  to = kubernetes_namespace.us_east_1a
  id = "us-east-1a"
}
import {
  to = kubernetes_namespace.us_east_1b
  id = "us-east-1a"
}
import {
  to = kubernetes_namespace.us_east_1c
  id = "us-east-1a"
}
```

```shell
# create a file generated.tf with the namespaces configuration 
terraform plan -generate-config-out=generated.tf

terraform plan -out=import_blocks.tfplan
# Plan: 3 to import, 0 to add, 0 to change, 0 to destroy.

terraform apply import_blocks.tfplan
# kubernetes_namespace.us-east-1b: Importing... [id=us-east-1a]
# kubernetes_namespace.us-east-1b: Import complete [id=us-east-1a]
# kubernetes_namespace.us-east-1c: Importing... [id=us-east-1a]
# kubernetes_namespace.us-east-1c: Import complete [id=us-east-1a]
# kubernetes_namespace.us-east-1a: Importing... [id=us-east-1a]
# kubernetes_namespace.us-east-1a: Import complete [id=us-east-1a]

# Apply complete! Resources: 3 imported, 0 added, 0 changed, 0 destroyed.
```
