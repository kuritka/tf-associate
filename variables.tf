
#variable "context" {
#  type        = string
#  default     = "k3d-east"
#  description = "The context to use for kubectl [k3d-east, k3d-west]"
#  validation {
#    condition     = contains(["k3d-east", "k3d-west"], var.context)
#    error_message = "The context cannot be empty"
#  }
#}

variable "region" {
  type        = string
  default     = "us-east"
  description = "The region to use for kubectl [us-east, eu-west]"
  validation {
    condition     = contains(["us-east", "eu-west"], var.region)
    error_message = "The region cannot be empty"
  }
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "The environment to use for kubectl [dev, prod]"
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "The environment cannot be empty"
  }
}


variable "cluster_ca_certificate" {
  type        = string
  description = "PEM encoded CA certificate for the cluster (REQUIRED)"
}

variable "client_key" {
  type        = string
  description = "PEM encoded client key for the cluster (REQUIRED)"
}

variable "client_certificate" {
  type        = string
  description = "PEM encoded client certificate for the cluster (REQUIRED)"
}

