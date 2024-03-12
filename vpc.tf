provider "aws" {
  region = "ap-southeast-2"
}


#实现vpc，我们用cloudformation，一个类似于terraform的，但是是specific to AWS
#我们可以直接用一个terraform module，直接建一个vpc，就可以包含route table，internet gateway等等，不用像之前一样写
#直接在terraform aws网站上找的一个包, 按照里面例子写
variable "vpc_cidr_block" {}
variable "private_subnet_cird_blocks" {}
variable "public_subnet_cird_blocks" {}

data "aws_availability_zones" "available" {}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.1"

  name = "myapp-vpc"
  cidr = var.vpc_cidr_block

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnet_cird_blocks
  public_subnets  = var.public_subnet_cird_blocks

  enable_nat_gateway   = true
  enable_dns_hostnames = true
  single_nat_gateway   = true

  tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                  = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                  = 1
  }
}
