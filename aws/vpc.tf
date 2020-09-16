module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.6"

  create_vpc = var.create_vpc

  name                 = "${var.cluster_name}-vpc"
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names

  # We can use private subnets too once https://github.com/aws/containers-roadmap/issues/607
  # is fixed
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = var.use_private_subnets
  single_nat_gateway   = var.use_private_subnets
  
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}


# =======================================================================

data aws_vpc unmanaged {
  count =  var.create_vpc ? 0 : 1
  id = var.unmanaged_vpc_id
}

data aws_subnet_ids unmanaged_public {
  # splat expr for conditional creation
  vpc_id = var.unmanaged_vpc_id

  filter {
    name   = "tag:Name"
    values = var.unmanaged_public_subnet_names         # can be patterns
  }
}

data aws_subnet_ids unmanaged_private {
  # splat expr for conditional creation
  vpc_id = var.unmanaged_vpc_id

  filter {
    name   = "tag:Name"
    values = var.unmanaged_private_subnet_names	# can be patterns
  }
}

data aws_subnet unmanaged_public {
   for_each = data.aws_subnet_ids.unmanaged_public.ids != null ? data.aws_subnet_ids.unmanaged_public.ids : toset([])
   id       = each.value
}

data aws_subnet unmanaged_private {
   for_each = data.aws_subnet_ids.unmanaged_private.ids != null ? data.aws_subnet_ids.unmanaged_private.ids : toset([])
   id       = each.value
}

data aws_nat_gateway nat_gateways {
   count = length(local.public_subnet_ids)
   subnet_id = local.public_subnet_ids[count.index]
}

