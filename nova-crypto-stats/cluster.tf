#############################################################################
##$$                    CLUSTER, SERVICE & TASKS                         $$##
#############################################################################

data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = "${var.environment}-${var.project}-cluster"
}
