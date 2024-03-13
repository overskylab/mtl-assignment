module "eks_worker_node_group" {
  source  = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version = "~> 20.8, < 21"

  name            = "eks-worker-nodegroup"
  cluster_name    = module.eks.cluster_name
  cluster_version = module.eks.cluster_version

  subnet_ids                        = module.vpc.private_subnets
  cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  vpc_security_group_ids = [
    module.eks.node_security_group_id,
  ]

  min_size     = 1
  max_size     = 10
  desired_size = 3
  disk_size    = 50

  ami_type = "BOTTLEROCKET_x86_64"
  platform = "bottlerocket"

  instance_types = ["t3a.medium"]
  capacity_type  = "ON_DEMAND"

  key_name = "intial"

  labels = {
    EKSCluster = module.eks.cluster_name
    NodeGroup  = "eks-worker-nodegroup"
  }

  update_config = {
    max_unavailable_percentage = 50
  }

  tags = merge(local.tags, { Separate = "eks-managed-node-group" })
}
