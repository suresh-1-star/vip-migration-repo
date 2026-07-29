provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source               = "../../../modules/vpc"
  name                 = "production-vpc"
  cidr_block           = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

module "target_group" {
  source   = "../../../modules/target-group"
  name     = "production-tg"
  vpc_id   = module.vpc.vpc_id
  port     = var.container_port
  protocol = "HTTP"
  tags     = var.tags
}

module "alb" {
  source             = "../../../modules/alb"
  name               = "production-alb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = var.alb_security_group_ids
  certificate_arn    = var.certificate_arn
  target_group_arn   = module.target_group.arn
  tags               = var.tags
}

module "ecs" {
  source             = "../../../modules/ecs-computing"
  cluster_name       = "production-cluster"
  task_family        = "production-task"
  service_name       = "production-service"
  container_name     = "production-container"
  container_image    = var.container_image
  container_port     = var.container_port
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_id  = var.ecs_security_group_id
  target_group_arn   = module.target_group.arn
}

module "route53" {
  source       = "../../../modules/route53"
  vpc_id       = module.vpc.vpc_id
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}