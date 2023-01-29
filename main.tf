# Setting provider in vars. Profile needs to exist locally or in github actions secret
provider "aws" {
  region = var.region
  profile = var.profile
}

resource "aws_iam_openid_connect_provider" "example" {
  url = "https://token.actions.githubusercontent.com" # URL of the identity provider
  client_id_list = ["sts.amazonaws.com"] # List of client IDs (also known as audiences)
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"] # List of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificates

}




