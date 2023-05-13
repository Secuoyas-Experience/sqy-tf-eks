module "backstage_reader_iam_user" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-user"
  name                          = "CanReadFromTechdocsUser"
  force_destroy                 = true
  password_reset_required       = true
  create_iam_user_login_profile = false
  create_iam_access_key         = true
}