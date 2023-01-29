variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
  type        = string
}
# the user account used for provisioning
variable "profile" {
  description = "AWS profile"
  default     = "devoriales_admin" # user account having AmazonEKSClusterPolicy read more on https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html
  type        = string
}
