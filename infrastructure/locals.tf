data "aws_availability_zones" "available" {}

locals {
  name   = "mtl-example"
  region = "ap-southeast-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  cluster_version = "1.29"

  tags = {
    Name      = local.name
    Terraform = "True"
  }
}
