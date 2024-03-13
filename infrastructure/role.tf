module "role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = ">= 4.3, < 5.0"

  create_role = true

  role_name        = "eks-irsa-app-api"
  role_description = "Created by Terraform"

  provider_urls = [
    "oidc.eks.ap-southeast-1.amazonaws.com/id/<<redacted>>"
  ]

  role_policy_arns = [
    module.policy.arn,
  ]

  oidc_fully_qualified_subjects = [
    "system:serviceaccount:default:app-api"
  ]

  tags = {
    Terraform = "True"
  }
}
