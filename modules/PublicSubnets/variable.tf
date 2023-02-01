variable "vpc_id" {}

variable "availability_zones" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "pub_subnet_name" {
  description = "A map of tags to be added to subnets"
  type        = list(string)
}

variable "subnets_cidr" {
  description = "List of CIDR's for subnets"
  type        = list(string)
}

variable "route_table_id" {
  description = "Route table to which subnets will be associated"
}