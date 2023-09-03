
variable "annotations" {
  type        = map(string)
  description = "The annotations to use for kubectl"
}

#variable "context" {
#  type        = string
#  description = "The context to use for kubectl [k3d-east, k3d-west]"
#}

variable "region" {
  type        = string
  description = "The region to use for kubectl [us-east, eu-west]"
}