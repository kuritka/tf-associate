
variable "context" {
  type        = string
  default     = "k3d-east"
  description = "The context to use for kubectl [k3d-east, k3d-west]"
  validation {
    condition     = contains(["k3d-east", "k3d-west"], var.context)
    error_message = "The context cannot be empty"
  }
}

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
