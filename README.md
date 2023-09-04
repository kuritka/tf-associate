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

# 3 - Backend in Kubernetes Cluster
I tried terraform cloud. Unfortunately it is unusable for demos on local k3d clusters. The problem is that the `terraform plan` 
runs on a host machine that can't connect to my local clusters.  If the demo was in AWS it would be a very good choice, due to 
the wide range of workspace settings, Variable sets and integration with github workflows.
To continue my demo on local k8s clusters - without AWS, I decided to use a local k8s cluster as a backend.

- https://developer.hashicorp.com/terraform/language/settings/backends/kubernetes
- 
```tf
terraform {
  backend "kubernetes" {
    secret_suffix    = "state"
    config_path      = "~/.kube/config"
    namespace        = "backend-state"
    config_context   = "k3d-backend"
  }
}
```

Backend state is stored as base64 encoded string in a secret
```shell
# move state to backend
❯ terraform init 


❯ k get secrets -A  --context=k3d-backend
NAMESPACE       NAME                                     TYPE                DATA   AGE
kube-system     k3s-serving                              kubernetes.io/tls   2      5m37s
kube-system     k3d-backend-server-0.node-password.k3s   Opaque              1      5m36s
kube-system     k3d-backend-agent-0.node-password.k3s    Opaque              1      5m32s
backend-state   tfstate-default-state                    Opaque              1      60s


❯ terraform plan -var-file=us-east.tfvars -out=us-east.tfplan
module.cluster.kubernetes_namespace.us_east_1a: Refreshing state... [id=us-east-1a]
module.cluster.kubernetes_namespace.us_east_1c: Refreshing state... [id=us-east-1c]
module.cluster.kubernetes_namespace.us_east_1b: Refreshing state... [id=us-east-1b]
```

_* For reverting back to local state follow these instructions: https://github.com/hashicorp/terraform/issues/33214#issuecomment-1553223031_ 


# 4 - Mutiple environments

![Screenshot 2023-09-04 at 10 59 18](https://github.com/kuritka/_helper/assets/7195836/839ca7ba-d2f4-4b93-b2e8-bd5042a02404)

- https://cloudcasts.io/course/terraform/environment-directories

Multiple environments can be done between git branches / folders / repos / workspaces (short-living). I chose the easiest way but a bit more difficult to maintain. Each environment or cluster has its own configuration and backend state. It is possible to extract tfvars and backend configurations to root , but terraform init will then require the `-chdir` argument

![Screenshot 2023-09-04 at 11 00 07](https://github.com/kuritka/_helper/assets/7195836/6057763c-8beb-493c-a141-4939130cc628)


```shell
# init migrate to backend automatically and clean terraform.tfstate
terraform init 
terraform plan -var-file=eu-west.tfvars -out=.out.tfplan
terraform apply .out.tfplan

...
terraform plan -var-file=us-east.tfvars -out=.out.tfplan
...
```
