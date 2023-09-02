# TerraformAssociate


## 1 - Import command , Import Block

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
  id = "us-east-1b"
}
import {
  to = kubernetes_namespace.us_east_1c
  id = "us-east-1c"
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


# 2 - Moving into modules 

Since I decided to extend the infrsatructure to another region, I extracted the resources into a module. Although I didn't make any changes, resourcy wanted to join because their name was changed from `kubernetes_namespace.us_east_1c` to `module.cluster.kubernetes_namespace.us_east_1c`

```shell
Plan: 3 to add, 0 to change, 0 to destroy.
``` 
What must be done is to remove the resources and import them again or use the `mv` command.

```shell
terraform state mv kubernetes_namespace.us_east_1c module.cluster.kubernetes_namespace.us_east_1c
# Move "kubernetes_namespace.us_east_1c" to "module.cluster.kubernetes_namespace.us_east_1c"
Successfully moved 1 object(s).

terraform state mv kubernetes_namespace.us_east_1b module.cluster.kubernetes_namespace.us_east_1b

terraform state mv kubernetes_namespace.us_east_1a module.cluster.kubernetes_namespace.us_east_1a
```

Because I did changes in annotations the `plan` command does only changes.

```shell
terraform plan -var-file=us-east.tfvars -out=us-east.tfplan
Plan: 0 to add, 3 to change, 0 to destroy.
```

If for some reason you keep import blocks, you have to refactor them as well:
```tf
# from
import {
  to = kubernetes_namespace.us_east_1c
  id = "us-east-1c"
}

# to
import {
  to = module.cluster.kubernetes_namespace.us_east_1c
  id = "us-east-1c"
}
```
