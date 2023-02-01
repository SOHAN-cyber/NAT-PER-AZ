variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "enable_classiclink" {
  description = "Do you want to enable classic support"
  type        = bool
  default     = true
}

variable "enable_classiclink_dns_support" {
  description = "Do you want to enable enable_classiclink_dns_support"
  type        = bool
  default     = true
}

variable "assign_generated_ipv6_cidr_block" {
  description = "Do you want to add ipv6 address to your vpc cidr"
  type        = bool
  default     = false
}

variable "name" {
  description = "Name of the VPC to be created"
  type        = string
  default     = "ld-vpc"
}

variable "tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default = {
    "owner" = "ot-ld"
    "env"   = "non-prod"
  }
}

variable "public_subnets_cidr" {
  description = "CIDR list for public subnet"
  type        = list(string)
  default     = ["10.10.208.0/21", "10.10.216.0/21"]
}

variable "private_subnets_cidr" {
  description = "CIDR list for private subnet"
  type        = list(string)
  default     = ["10.10.224.0/24", "10.10.225.0/24", "10.10.226.0/24", "10.10.227.0/24", "10.10.228.0/24", "10.10.229.0/24"]
}

variable "avaialability_zones" {
  description = "List of avaialability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "public_web_sg_name" {
  type    = string
  default = "public_security_group"
}

variable "lb_log_bucket_name" {
  description = "Name of bucket where we would be storing our logs"
  type        = string
  default     = "opstr-log-tree1"
}

variable "pvt_rt_name" {
  description = "Name of the private route table"
  type        = list(string)
  default     = ["ld-private-1", "ld-private-2"]
}

variable "logs_bucket_arn" {
  description = "ARN of bucket where we would be storing vpc our logs"
  type        = string
  default     = null
}

variable "pvt_zone_name" {
  description = "Name of private zone"
  type        = string
  default     = "lenden.com"
}

variable "pub_subnet_name" {
  description = "public subnet name"
  type        = list(string)
  default     = ["ld-np-pub-subnet-1", "ld-np-pub-subnet-2"]
}

variable "pvt_subnet_name" {
  description = "private subnet name"
  type        = list(string)
  default     = ["ld-np-app-pvt-subnet-1", "ld-np-app-pvt-subnet-2", "ld-np-db-pvt-subnet-1", "ld-np-db-pvt-subnet-2", "ld-np-middleware-pvt-subnet-1", "ld-np-middleware-pvt-subnet-2"]
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

variable "log_destination_type" {
  type    = string
  default = "s3"
}

variable "traffic_type" {
  type    = string
  default = "ALL"
}

variable "enable_vpc_logs" {
  type    = bool
  default = false
}

variable "enable_alb_logging" {
  type    = bool
  default = true
}

variable "alb_certificate_arn" {
  description = "Cretificate arn for alb"
  type        = string
  default     = null
}

variable "enable_deletion_protection" {
  type    = bool
  default = false
}

variable "enable_igw_publicRouteTable_PublicSubnets_resource" {
  type        = bool
  description = "This variable is used to create IGW, Public Route Table and Public Subnets"
  default     = true
}

variable "enable_nat_privateRouteTable_PrivateSubnets_resource" {
  type        = bool
  description = "This variable is used to create NAT, Private Route Table and Private Subnets"
  default     = true
}

variable "enable_public_web_security_group_resource" {
  type        = bool
  description = "This variable is to create Web Security Group"
  default     = true
}

variable "single_nat_gateway" {
  description = "Do you want to create a single nat gateway"
  type        = bool
  default     = true
}

variable "nat_gateway_name" {
  description = "Name of natgateway"
  type        = list(string)
  default     = ["ld-nat-1", "ld-nat-2"]
}

variable "enable_pub_alb_resource" {
  type        = bool
  description = "This variable is to create ALB"
  default     = true
}

variable "enable_aws_route53_zone_resource" {
  type        = bool
  description = "This variable is to create Route 53 Zone"
  default     = true
}

variable "enable_per_hourPartition" {
  description = "Do you want to create S3 bucket"
  type        = bool
  default     = false
}

variable "hive_compatible_partitions" {
  description = "Hive-compatible prefixes for flow logs stored in Amazon S3"
  type        = bool
  default     = false
}
variable "max_aggregation_interval" {
  description = "(optional) describe your variable"
  type        = number
  default     = 300
}

variable "file_format" {
  description = "In which format you want the logs to created"
  type        = string
  default     = "parquet"
}

variable "bucket_name" {
  description = "Name of the S3 Bucket you want to create"
  type        = string
  default     = "vp-fl-lg"
}
variable "enable_vpc_endpoint" {
  description = "Do you want to enable vpc endpoint"
  type        = bool
  default     = true
}

variable "service_name" {
  description = "Name of the endpoint service name"
  type        = string
  default     = "com.amazonaws.ap-south-1.s3"
}

variable "vpc_endpoint_type" {
  description = "Type of s3 endpoint you want"
  type        = string
  default     = "Gateway"
}


variable "enable_pub_alb" {
  description = "do you want to enable public alb"
  type        = bool
  default     = true
}

variable "acl_type" {
  description = "acl type you want to create"
  type        = string
  default     = "private"
}

variable "force_destroy" {
  description = "Do you want to enable force destroy"
  type        = bool
  default     = true
}
