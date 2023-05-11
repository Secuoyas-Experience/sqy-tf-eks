output "terraform_cloud_oidc_arn" {
  value = data.aws_iam_openid_connect_provider.terraform_cloud_oidc_provider.arn
}

output "github_cloud_oidc_arn" {
  value = aws_iam_openid_connect_provider.github_oidc_provider.arn
}


