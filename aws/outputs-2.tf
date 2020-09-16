# -------------------------------------------------------------------

output unmanaged_vpc_id {
       value = var.unmanaged_vpc_id
}

output vpc_cidr {
       value = var.vpc_cidr
}

output unmanaged_vpc_name {
       value = local.unmanaged_vpc_name
}

output eks_efs_subnet_ids {
       value = local.eks_efs_subnet_ids
}

output unmanaged_public_subnet_ids {
       value = local.unmanaged_public_subnet_ids
}

output unmanaged_private_subnet_ids {
       value = local.unmanaged_private_subnet_ids
}

output public_subnet_cidrs {
  value = local.public_subnet_cidrs
}

output unmanaged_public_subnet_names {
  value = local.unmanaged_public_subnet_names
}

output private_subnet_cidrs {
  value = local.private_subnet_cidrs
}

output unmanaged_private_subnet_names {
  value = local.unmanaged_private_subnet_names
}

output nat_cidrs {
  value = local.nat_ip_cidrs
}

output cluster_endpoint_public_access_cidrs {
  value = local.cluster_endpoint_public_access_cidrs
}
