module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.8, < 21"

  cluster_name                   = local.name
  cluster_version                = local.cluster_version
  cluster_endpoint_public_access = false

  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  cluster_encryption_config = {
    provider_key_arn = aws_kms_key.key.arn
    resources        = ["secrets"]
  }

  tags = local.tags
}


resource "aws_kms_key" "key" {
  description              = "Encrypt secrets for EKS cluster"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  multi_region             = false
  enable_key_rotation      = true
  deletion_window_in_days  = 30

  tags = local.tags
}
