variable "subnets_for_nat_gw" {
  type = list(string)
}

variable "vpc_name" {
  description = "Name of VPC in which NAT will be created"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "nat_gateway_name" {
  type = list(string)
}

variable "single_nat_gateway" {
  description = "Do you want to create single az nat gateway"
  type        = bool
}

