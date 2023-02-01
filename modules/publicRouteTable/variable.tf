variable "vpc_id" {
  description = "VPC ID in which Route table needs to be created"
  type        = string
}

variable "name" {
  description = "Name of Route Table To be created"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "cidr_block" {
  description = "Cidr block for route"
  type        = string
}

variable "gateway_id" {
  description = "Internet gateway id"
  type        = string
}
