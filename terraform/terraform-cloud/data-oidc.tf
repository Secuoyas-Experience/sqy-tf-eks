data "aws_iam_openid_connect_provider" "terraform_cloud_oidc_provider" {
  url = "https://token.actions.githubusercontent.com"
}