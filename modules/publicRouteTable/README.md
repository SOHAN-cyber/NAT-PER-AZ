Route Table Terraform Module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Terraform module which creates route table on AWS.

Terraform versions
------------------

Terraform >= v0.14

Usage
------
```hcl
provider aws {
    region = "ap-south-1"
}

module "route_table" {
    source = "OT-CLOUD-KIT/route-table/aws"
    vpc_id = "vpc-0b5c682bc0acb3a96"
    name = "testing-rt"

    tags = {
        Owner = "Opstree opensource"
        Environment = "test"
    }

    routes = {
        "0.0.0.0/0" = "igw-0c5a82785d6d82970"
        "172.16.0.0/24" = "eni-0852527640e7b366d"
        "192.168.0.0/16" = "vgw-02f60d440b6293326"
    }
}
```

Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.
* Default Tags are an easy way to standardize your Terraform Configuration in accordance with AWS’s recommended best practices. We have used the new AWS provider (v3.38.0) feature which allows default_tags to be mentioned in the provider block and will be inherited by dependent Terraform resources and modules


## Inputs       

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc_id | Id of your vpc | string | "" | yes |
| name | Name of the route table | string | "" | yes |
| tags | Tags to include in the route table | map | {} | no |
| routes | Map of routes to be created in the route table | map | {} | no |     
  

Output
------
| Name | Description |
|------|-------------|
| id | The ID of the route table |

### Contributors

[![Prakash Jha][prakash_avatar]][prakash_homepage]<br/>[Prakash Jha][prakash_homepage] 

  [prakash_homepage]: https://github.com/prakashjha-ot
  [prakash_avatar]: https://img.cloudposse.com/75x75/https://github.com/prakashjha-ot.png
