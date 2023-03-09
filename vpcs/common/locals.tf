locals {
  vpc_cidr_block = "10.32.0.0/16"
  subnets = {
    private = [
      cidrsubnet(local.vpc_cidr_block, 4, 0),
      cidrsubnet(local.vpc_cidr_block, 4, 2),
      cidrsubnet(local.vpc_cidr_block, 4, 4),
    ]

    public = [
      cidrsubnet(local.vpc_cidr_block, 6, 4),
      cidrsubnet(local.vpc_cidr_block, 6, 12),
      cidrsubnet(local.vpc_cidr_block, 6, 20),
    ]

    database = [
      cidrsubnet(local.vpc_cidr_block, 6, 5),
      cidrsubnet(local.vpc_cidr_block, 6, 13),
      cidrsubnet(local.vpc_cidr_block, 6, 21),
    ]

    elasticache = [
      cidrsubnet(local.vpc_cidr_block, 6, 6),
      cidrsubnet(local.vpc_cidr_block, 6, 14),
      cidrsubnet(local.vpc_cidr_block, 6, 22),
    ]
  }

  cluster_name = var.cluster_name == "" ? var.name : var.cluster_name
  k8s_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
  # These tags are used by AWS Load Balancer Controller for subnet auto-discovery https://kubernetes-sigs.github.io/aws-load-balancer-controller/latest/deploy/subnet_discovery/
  private_subnet_tags = merge({ "kubernetes.io/role/internal-elb" = "1" }, local.k8s_tags)
  public_subnet_tags  = merge({ "kubernetes.io/role/elb" = "1" }, local.k8s_tags)
}
