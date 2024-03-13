module "policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = ">= 4.3, < 5.0"

  name        = "eks-irsa-app-api"
  path        = "/"
  description = "Policies for app api"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject*",
        "s3:PutObject*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::my-web-assets"
      ]
    },
    {
      "Action": [
        "sqs:SendMessage",
        "sqs:SendMessageBatch",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:DeleteMessageBatch"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:sqs:ap-southeast-1:123456789123:lms-import-data"
      ]
    }
  ]
}
EOF

  tags = {
    Terraform = "True"
  }
}
