provider "aws" {
  region = var.aws_region
}

# ------------------------------------------------------------------------------
# 1. VPC MODULE
# ------------------------------------------------------------------------------
module "vpc" {
  source               = "../../../modules/vpc"
  name                 = "staging-vpc"
  cidr_block           = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = var.tags
}

# ------------------------------------------------------------------------------
# 2. ALB MODULE (A.1 - A.4 HTTP REDIRECT & TSK-401 SSL/TLS)
# ------------------------------------------------------------------------------
module "alb" {
  source             = "../../../modules/alb"
  name               = "staging-alb"
  internal           = var.alb_internal # Can toggle public/private
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = var.alb_security_group_ids
  certificate_arn    = var.certificate_arn # TSK-401 ACM Certificate
  target_group_arn   = module.target_group.target_group_arn
  tags               = var.tags
}

# ------------------------------------------------------------------------------
# 3. TARGET GROUP MODULE (TSK-301 HEALTH CHECKS)
# ------------------------------------------------------------------------------
module "target_group" {
  source                = "../../../modules/target-group"
  name                  = var.target_group_name
  port                  = var.container_port
  vpc_id                = module.vpc.vpc_id
  target_type           = "ip"                  # Mandatory for ECS Fargate
  health_check_path     = var.health_check_path # TSK-301.1 (/health)
  health_check_matcher  = "200"                 # TSK-301.2 (HTTP 200 OK)
  health_check_interval = 15                    # TSK-301.3 (15s interval)
  health_check_timeout  = 5                     # TSK-301.3 (5s timeout)
  healthy_threshold     = 2                     # TSK-301.4 (2 successes)
  unhealthy_threshold   = 3                     # TSK-301.4 (3 failures)
  tags                  = var.tags
}

# ------------------------------------------------------------------------------
# 4. HTTPS LISTENER RULE (C.1 - C.4 F5 iRULE URI PATH REWRITE)
# ------------------------------------------------------------------------------
resource "aws_lb_listener_rule" "api_v1_rewrite" {
  listener_arn = module.alb.https_listener_arn
  priority     = 10 # C.1 Priority 10

  action {
    type             = "forward"
    target_group_arn = module.target_group.target_group_arn # C.3 & C.4 Forward to Target Group
  }

  # F5 URI Rewrite Transformation is not supported by the current AWS provider ALB listener rule schema.
  # The rule will still match /api/v1/* and forward traffic to the target group.

  # C.2 Path Condition matching /api/v1/*
  condition {
    path_pattern {
      values = ["/api/v1/*"]
    }
  }
}

# ------------------------------------------------------------------------------
# 5. ECS COMPUTE MODULE
# ------------------------------------------------------------------------------
module "ecs" {
  source             = "../../../modules/ecs-computing"
  cluster_name       = "staging-cluster"
  task_family        = "staging-task"
  service_name       = "staging-service"
  container_name     = "staging-container"
  container_image    = var.container_image
  container_port     = var.container_port
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_id  = var.ecs_security_group_id
  target_group_arn   = module.target_group.target_group_arn # Connects ECS service to Target Group
}

# ------------------------------------------------------------------------------
# 6. ROUTE 53 MODULE (TSK-201 HYBRID DNS & CUTOVER)
# ------------------------------------------------------------------------------
module "route53" {
  source      = "../../../modules/route53"
  zone_id     = var.route53_zone_id
  record_name = var.route53_record_name
  records     = [var.route53_target]
}