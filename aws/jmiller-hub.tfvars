# Put your cluster where your data is
region = "us-east-1"

# Name of your cluster
cluster_name = "jmiller-hub"

allowed_roles = ["arn:aws:iam::328656936502:role/jupyterhub-deploy"]

# # ============================================================================================================

# # Configured for unmanaged private subnets created by IT

# use_private_subnets = true
# create_vpc = false

# vpc_cidr = "10.128.0.0/9"                        # managed or unmanaged for EKS and EFS.  single block only

# unmanaged_vpc_id = "vpc-0609d0f2a72ccf96d"       # sandbox 
# unmanaged_private_subnet_names = ["*Private*"]   # or e.g. "*DMZ*", can be patterns or literal

# # cluster_create_security_group = false
# # cluster_security_group_id = "sg-0534a0b113cbd8501"                    # EKS cluster-to-cluster
# worker_create_security_group = false
# worker_additional_security_group_ids = ["sg-0a5f153ac7a17d80c"]       # Access to cluster, plugs into cluster_security_group_id
# worker_security_group_id = "sg-0a42f0a8c84e73579"                     #


# ============================================================================================================

# Configured for managed private subnets created by Terraform

use_private_subnets = true
create_vpc = true

vpc_cidr = "172.16.0.0/16"

public_subnets =  ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
private_subnets = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]

