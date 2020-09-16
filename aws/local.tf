locals {

       # ====================================================================================
       # Networking:  (managed, unmanaged vpc) x (public, private subnets)
       # ====================================================================================

       vpc_id = var.create_vpc ? lookup(module.vpc, "vpc_id") : var.unmanaged_vpc_id 

       vpc_name = var.create_vpc ? lookup(module.vpc, "name") : local.unmanaged_vpc_name

       eks_efs_subnet_ids = var.create_vpc ? local.managed_subnet_ids : local.unmanaged_subnet_ids

       managed_subnet_ids = var.use_private_subnets ? module.vpc.private_subnets : module.vpc.public_subnets

       private_subnet_ids = var.create_vpc ? module.vpc.private_subnets : local.unmanaged_private_subnet_ids

       public_subnet_ids =  var.create_vpc ? module.vpc.public_subnets : local.unmanaged_public_subnet_ids

       unmanaged_vpc_name = data.aws_vpc.unmanaged[*] != [] ? data.aws_vpc.unmanaged[0].tags["Name"] : "UNDEFINED-vpc-name"

       unmanaged_subnet_ids = var.use_private_subnets ? local.unmanaged_private_subnet_ids : local.unmanaged_public_subnet_ids
       
       unmanaged_public_subnet_ids = tolist((data.aws_subnet_ids.unmanaged_public[*].ids)[0])

       unmanaged_private_subnet_ids = tolist((data.aws_subnet_ids.unmanaged_private[*].ids)[0])

       private_subnet_cidrs  = var.create_vpc ? module.vpc.private_subnets : local.unmanaged_private_subnet_cidrs
       public_subnet_cidrs  = var.create_vpc ? module.vpc.public_subnets : local.unmanaged_public_subnet_cidrs
       unmanaged_private_subnet_cidrs = [for s in data.aws_subnet.unmanaged_private : s.cidr_block]
       unmanaged_public_subnet_cidrs = [for s in data.aws_subnet.unmanaged_public : s.cidr_block]
       unmanaged_private_subnet_names = [for s in data.aws_subnet.unmanaged_private : s.tags["Name"]]
       unmanaged_public_subnet_names = [for s in data.aws_subnet.unmanaged_public : s.tags["Name"]]

       nat_ip_cidrs = [ for nat in data.aws_nat_gateway.nat_gateways : join("", [nat.public_ip, "/32"]) ]
       combined_cidrs = concat(local.nat_ip_cidrs, var.cluster_endpoint_public_access_extra_cidrs)
       cluster_endpoint_public_access_cidrs = var.create_vpc ? null : (var.use_private_subnets ? local.combined_cidrs : null)
}
