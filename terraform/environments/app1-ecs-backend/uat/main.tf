provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source               = "../../../modules/vpc"
  name                 = "uat-vpc"
  cidr_block           = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = var.tags
}

# 1. Standalone Target Group Module
module "target_group" {
  source = "../../../modules/target-group"
  name   = "uat-tg"
  vpc_id = module.vpc.vpc_id
  port   = var.container_port
  tags   = var.tags
}

# 2. ALB Module
module "alb" {
  source             = "../../../modules/alb"
  name               = "uat-alb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = var.alb_security_group_ids
  tags               = var.tags

  target_group_arn = module.target_group.target_group_arn
  certificate_arn  = var.certificate_arn
}

# 3. ECS Service
module "ecs" {
  source             = "../../../modules/ecs-computing"
  cluster_name       = "uat-cluster"
  task_family        = "uat-task"
  service_name       = "uat-service"
  container_name     = "uat-container"
  container_image    = var.container_image
  container_port     = var.container_port
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_id  = var.ecs_security_group_id
  target_group_arn   = module.target_group.target_group_arn
}

# 4. Route53
module "route53" {
  source      = "../../../modules/route53"
  zone_id     = var.route53_zone_id
  record_name = var.route53_record_name
  records     = [var.route53_target]
}