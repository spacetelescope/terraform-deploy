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

output eks_subnet_ids {
       value = local.eks_subnet_ids
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

output worker_create_security_group {
  value = var.worker_create_security_group
}

output worker_security_group_id {
  value = var.worker_security_group_id
}


