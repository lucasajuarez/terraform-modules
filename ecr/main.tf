module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = var.repository_name
  repository_image_tag_mutability = "MUTABLE"
  create_repository = var.create_repository
  #repository_read_write_access_arns = [tostring(var.role_arn)] # TODO create iam role and policy as code
  repository_lifecycle_policy = jsonencode(
    {
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 10 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 10
        },
        action = {
          type = "expire"
        }
      }
    ]
  }
  )

create_repository_policy = false

repository_policy = jsonencode({
  Statement = [
    {
      Sid       = "AllowPushPull"
      Effect    = "Allow"
      Action    = [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:TagResource",
        "ecr:UntagResource"
      ]
      Principal = {
        AWS = var.principal_arns
      }
    }
  ]
})

  tags = {
    Terraform   = "true"
  }

}

