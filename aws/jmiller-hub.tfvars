# Put your cluster where your data is
region = "us-east-1"

# Name of your cluster
cluster_name = "jmiller-hub"

allowed_roles = ["arn:aws:iam::328656936502:role/jupyterhub-deploy"]

# # ============================================================================================================

# # Configured for unmanaged private subnets created by IT

use_private_subnets = true
create_vpc = false

vpc_cidr = "10.144.0.0/12"                        # managed or unmanaged for EKS and EFS.  single block only

unmanaged_vpc_id = "vpc-0609d0f2a72ccf96d"       # sandbox
unmanaged_public_subnet_names = ["DEV-WF-SC-SB-Public-*"]
unmanaged_private_subnet_names = ["DEV-WF-SC-SB-Private-*"]

# cluster_endpoint_public_access_cidrs = [    # sandbox private subnet NAT public EIPs allowed to access EKS public API endpoint
#     "54.166.30.127/32",
#     "54.157.243.2/32",
#     "34.197.199.244/32",
# ]

# ============================================================================================================

# Configured for managed private subnets created by Terraform


# use_private_subnets = true
# create_vpc = true

# vpc_cidr = "172.16.0.0/16"

# public_subnets =  ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
# private_subnets = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]

