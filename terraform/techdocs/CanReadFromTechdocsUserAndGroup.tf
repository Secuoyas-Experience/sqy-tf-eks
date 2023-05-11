module "backstage_reader_iam_user" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-user"
  name                          = "CanReadFromTechdocsUser"
  force_destroy                 = true
  password_reset_required       = true
  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

module "backstage_reader_user_group" {
  source                   = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  name                     = "CanReadFromTechdocsGroup"
  group_users              = [module.backstage_reader_iam_user.iam_user_name]
  custom_group_policy_arns = [aws_iam_policy.backstage_read_policy.arn]
  enable_mfa_enforcment    = false
}