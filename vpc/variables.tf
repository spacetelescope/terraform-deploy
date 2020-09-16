variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "test-cluster-change-name"
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)
  default = [ ]
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
  ]
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
  ]
}

# -------------------------------------------------------------------------
#                     Networking config 

# ========================================================================
# Always define

variable create_vpc {
    description = "When true,  Terraform creates VPC, subnet, etc. resources"
    type = bool
    default = false   #  XXXX true
}

variable use_private_subnets {
    description = "Use private subnets for EKS worker nodes."
    type        = bool
    default = true   # XXXX false
}

variable vpc_cidr {
    description = "IP range of subnets"
    type = string
    default = "172.16.0.0/16"
}

# ========================================================================
# Define when create_vpc is false (i.e. for unmanaged (externally created)
# vpc and subnets.

variable unmanaged_vpc_id {
   description = "ID of unmanaged VPC, e.g. created by IT department."
   type = string
   default = ""
}

variable unmanaged_public_subnet_names {
   description = "Pattern applied to Name tag to select unmanaged public subnets from the unmanaged vpc"
   type = list(string)
   default = ["*Public*"]
}

variable unmanaged_private_subnet_names {
   description = "Patterns applied to Name tag to select unmanaged private subnets from the unmanaged vpc"
   type = list(string)
   default = ["*Private*"]
}

variable cluster_create_security_group {
   description = "If true,  EKS module should create security group for group-to-cluster accesss."
   type = bool
   default = true
}

variable cluster_security_group_id {
   description = "ID of security group for EKS cluster self-trust."
   type = string
   default = null
}

variable worker_create_security_group {
   description = "If true,  EKS module should create security group for accessing EKS endpoint for private workers and CI-nodes."
   type = bool
   default = true
}

variable worker_security_group_id {
   description = "ID of security group to which EKS worker and terraform deployment nodes will be assigned."
   type = string
   default = null
}

variable worker_additional_security_group_ids {
   description = "Security group accepting 443 ingress from worker_security_group_id"
   type = list(string)
   default = null
}

# ========================================================================
# Define when create_vpc is true (i.e. for managed vpc and subnets)

variable public_subnets {  
    description = "Public subnet IP ranges."
    type        = list(string)
    default = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
}

variable private_subnets {  
    description = "Private subnet IP ranges."
    type        = list(string)
    default = []   #   ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
}

variable allowed_roles {
    default = []
}
