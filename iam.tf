
# custom trust policy for oidc provider
data "aws_iam_policy_document" "oidc_trust_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }
    condition {
      test = "StringLike"
      variable = "token.actions.githubusercontent.com:aud"
      values = ["sts.amazonaws.com"]
    }
    condition {
      test = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = ["repo:devoriales/oidc-aws-github:*"]
    }

  }
    statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    }  
}


data "aws_caller_identity" "current" {}


# resource to create an iam role
resource "aws_iam_role" "gh-role" {
  name = "oidc-gh-role"
  assume_role_policy = data.aws_iam_policy_document.oidc_trust_policy.json
}

# resource for iam role policy
resource "aws_iam_role_policy" "gh-lambda-policies" {
  name = "oidc-gh-policies"
  role = aws_iam_role.gh-role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "iam:PassRole"
      ],
      "Resource": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.gh-role.name}"
    },
    {
      "Sid": "VisualEditor1",
      "Effect": "Allow",
      "Action": [
        "lambda:CreateFunction",
        "lambda:InvokeFunction",
        "lambda:UpdateFunctionCode",
        "lambda:DeleteFunction",
        "lambda:GetFunction"
      ],
      "Resource": "arn:aws:lambda:eu-west-1:${data.aws_caller_identity.current.account_id}:function:*"
    }
  ]
}
EOF
}
