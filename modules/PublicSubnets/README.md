Subnets Terraform Module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Terraform module which creates subnets in AWS.

Terraform versions
------------------

Terraform 0.12.

Usage
------
```hcl
module "Subnets" {
  source = "./modules/Subnets/"
  vpc_id = module.vpc.vpc_id 
  subnet_cidr = var.private_subnet_cidr 
  sub_az = var.sub_az # availabilty zone 
}
```

Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.

## Otput 

```
# subnet id
```
