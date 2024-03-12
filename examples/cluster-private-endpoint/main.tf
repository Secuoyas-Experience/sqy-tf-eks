###########################################################
##                       IMPORTANT                       ##
##                       ---------                       ##
## Before removing EKS public endpoint, just make sure   ##
## you have kubectl access to private endpoint via VPN   ##
## otherwise you will see yourself out of the cluster    ##
##                                                       ##
## 1. create cluster with public endpoint                ##
## 2. create VPN to access private subnets               ##
## 3. add sg rules to allow access from private subnets  ##
## 4. from VPN change to private endpoint                ##
###########################################################

module "cluster" {
  source                           = "../.."
  cluster_name                     = "my-domain-es"
  cluster_kubernetes_version       = "1.29"
  cluster_cidr                     = "10.0.0.0/16"
  cluster_region                   = "eu-central-1"
  cluster_public_endpoint_enabled  = false # removes public endpoint
  cluster_private_endpoint_enabled = true  # enables private endpoint
  cluster_azs                      = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  cluster_private_subnets          = ["10.0.0.0/18", "10.0.64.0/18", "10.0.128.0/24"]
  cluster_public_subnets           = ["10.0.192.0/24", "10.0.193.0/24", "10.0.194.0/24"]
  inception_min_size               = 1
  inception_max_size               = 1
  inception_desired_size           = 1
  environment                      = "dev"
  organization                     = "my.domain.es"

  # EXTRA SG RULES (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)
  cluster_security_group_additional_rules = {
    # VPN ACCESS TO EKS
    vpn = {
      description = "allow VPN connections from specific subnet to access EKS"
      from_port   = "80"
      to_port     = "443"
      protocol    = "tcp"
      type        = "ingress"
      cidr_blocks = ["10.0.64.0/18"]
    }
  }
}