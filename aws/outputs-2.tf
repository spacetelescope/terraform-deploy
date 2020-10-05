# -------------------------------------------------------------------

output vpc_id {
       value = local.vpc_id
}

output vpc_name {
       value = var.vpc_name
}

output public_subnet_ids {
       value = local.public_subnet_ids
}
output public_subnet_cidrs {
  value = local.public_subnet_cidrs
}
output public_subnet_names {
  value = local.public_subnet_names
}

output private_subnet_ids {
       value = local.private_subnet_ids
}
output private_subnet_cidrs {
  value = local.private_subnet_cidrs
}
output private_subnet_names {
  value = local.private_subnet_names
}
