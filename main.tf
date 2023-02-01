resource "aws_vpc" "main" {
  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block

  tags = merge(
    {
      "Name" = format("%s", "${var.name}-vpc")
    },
    var.tags,
  )
}

resource "aws_flow_log" "vpc_flow_logs" {
  count                    = var.enable_vpc_logs == true ? 1 : 0
  log_destination          = var.logs_bucket_arn module.pub_alb[0].bucket_arn
  log_destination_type     = var.log_destination_type
  traffic_type             = var.traffic_type
  vpc_id                   = aws_vpc.main.id
  max_aggregation_interval = var.max_aggregation_interval
  destination_options {
    file_format                = var.file_format
    per_hour_partition         = var.enable_per_hourPartition
    hive_compatible_partitions = var.hive_compatible_partitions
  }
}


resource "aws_internet_gateway" "igw" {
  count  = var.enable_igw_publicRouteTable_PublicSubnets_resource == true ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name" = format("%s-igw", var.name)
    },
    var.tags,
  )
}

module "PublicSubnets" {
  source = "./modules/PublicSubnets"
  count  = var.enable_igw_publicRouteTable_PublicSubnets_resource == true ? 1 : 0
  availability_zones = var.avaialability_zones
  pub_subnet_name    = var.pub_subnet_name
  route_table_id     = module.publicRouteTable.id
  subnets_cidr       = var.public_subnets_cidr
  vpc_id             = aws_vpc.main.id
  tags               = var.tags
}

module "nat-gateway" {
  source = "./modules/nat-gateway"
  count  = var.enable_nat_privateRouteTable_PrivateSubnets_resource == true ? 1 : 0
  single_nat_gateway = var.single_nat_gateway
  nat_gateway_name   = var.nat_gateway_name
  subnets_for_nat_gw = module.PublicSubnets[count.index].ids
  vpc_name           = var.name
  tags               = var.tags
}

module "publicRouteTable" {
  source = "./modules/publicRouteTable"
  vpc_id     = aws_vpc.main.id
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw[0].id
  name       = format("%s-pub", var.name)
}

module "privateRouteTable" {
  source = "./modules/privateRouteTable"
  count  = var.single_nat_gateway ? 1 : length(var.public_subnets_cidr)
  cidr_block         = "0.0.0.0/0"
  vpc_id             = aws_vpc.main.id
  gateway_id         = module.nat-gateway.*.id[0][count.index]
  single_nat_gateway = var.single_nat_gateway
  name               = format("%s-pvt-${count.index + 1}", var.name)
  tags               = var.tags
}


module "PrivateSubnets" {
  source = "./modules/PrivateSubnets"
  count  = var.enable_nat_privateRouteTable_PrivateSubnets_resource == true ? 1 : 0
  availability_zones = var.avaialability_zones
  single_nat_gateway = var.single_nat_gateway
  pvt_subnet_name    = var.pvt_subnet_name
  subnets_for_nat_gw = module.PublicSubnets[count.index].ids
  subnets_cidr       = var.private_subnets_cidr
  vpc_id             = aws_vpc.main.id
  route_table_id     = module.privateRouteTable.*.id
  tags               = var.tags
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = var.service_name
  vpc_endpoint_type = var.vpc_endpoint_type
}

resource "aws_vpc_endpoint_route_table_association" "vpc_endpoint" {
  count           = var.single_nat_gateway ? 1 : length(var.public_subnets_cidr)
  route_table_id  = module.privateRouteTable[count.index].id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

module "public_web_security_group" {
  source              = "OT-CLOUD-KIT/security-groups/aws"
  version             = "1.0.0"
  enable_whitelist_ip = true
  name_sg             = "Public web Security Group"
  vpc_id              = aws_vpc.main.id
  ingress_rule = {
    rules = {
      rule_list = [
        {
          description  = "Rule for port 80"
          from_port    = 80
          to_port      = 80
          protocol     = "tcp"
          cidr         = ["0.0.0.0/0"]
          source_SG_ID = []
        },
        {
          description  = "Rule for port 443"
          from_port    = 443
          to_port      = 443
          protocol     = "tcp"
          cidr         = ["0.0.0.0/0"]
          source_SG_ID = []
        }
      ]
    }
  }
}

module "pub_alb" {
  source = "./modules/pub_alb"
  count  = var.enable_pub_alb ? 1 : 0
  alb_name                   = format("%s-pub-alb", var.name)
  internal                   = false
  force_destroy              = var.force_destroy
  acl_type                   = var.acl_type
  lb_log_bucket_name         = "opstr-log-tree5"
  security_groups_id         = [module.public_web_security_group.sg_id]
  subnets_id                 = module.PublicSubnets[count.index].ids
  tags                       = var.tags
  enable_logging             = var.enable_alb_logging
  enable_deletion_protection = var.enable_deletion_protection
}

resource "aws_route53_zone" "private_hosted_zone" {
  name = var.pvt_zone_name
  vpc {
    vpc_id = aws_vpc.main.id
  }
}
