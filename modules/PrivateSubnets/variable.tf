variable "vpc_id" {}


variable "availability_zones" {
  type = list(string)
}

variable "pvt_subnet_name" {
  description = "A map of tags to be added to subnets"
  type        = list(string)
}

variable "tags" {
  type = map(string)
}


variable "subnets_cidr" {
  description = "List of CIDR's for subnets"
  type        = list(string)
}

variable "route_table_id" {
  description = "Route table to which subnets will be associated"
  type        = list(string)
}

variable "routetable_association" {
  description = "Route table association"
  type        = bool
  default     = true
}

variable "subnets_for_nat_gw" {
  description = "subnet for nat gateway"
  type        = list(string)
}

variable "single_nat_gateway" {
  description = "Do you have single nat gateway enabled"
  type        = bool
}