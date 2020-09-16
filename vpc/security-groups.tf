resource aws_security_group eks_cluster {
  name        = "${var.cluster_name}-eks-cluster-sg"
  description = "Allows communitation with EKS cluster"
  vpc_id      = local.vpc_id
  revoke_rules_on_delete = true

  ingress {
    description = "EKS cluster communication with self"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-eks-cluster-sg"
  }
}

# ----------------------------------------------------------------------------

resource aws_security_group eks_worker_additional {
  name        = "${var.cluster_name}-eks-worker-additional-sg"
  description = "Allows communitation from worker security group"
  vpc_id      = local.vpc_id
  revoke_rules_on_delete = true

  ingress {
    description = "Ingress from workers on 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.eks_worker_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-eks-worker-additional-sg"
  }
}

# ----------------------------------------------------------------------------


resource aws_security_group eks_worker_sg {
  name        = "${var.cluster_name}-eks-worker-sg"
  description = "Defines workers, worker-to-worker, worker-to-additional-sg"
  vpc_id      = local.vpc_id
  revoke_rules_on_delete = true

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-eks-worker-sg"
  }
}

resource aws_security_group_rule eks_worker_additional_self_rule {
  description = "Opens all ports for worker-to-worker"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self = true
  security_group_id = aws_security_group.eks_worker_sg.id
}

resource aws_security_group_rule eks_worker_additional_https_rule {
  description = "Opens 443 on worker nodes."
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = aws_security_group.eks_worker_additional.id
  security_group_id = aws_security_group.eks_worker_sg.id
}

resource aws_security_group_rule eks_worker_additional_high_rule {
  description = "Opens high ports on worker nodes."
  type              = "ingress"
  from_port         = 1025
  to_port           = 65535
  protocol          = "tcp"
  source_security_group_id = aws_security_group.eks_worker_additional.id
  security_group_id = aws_security_group.eks_worker_sg.id
}
