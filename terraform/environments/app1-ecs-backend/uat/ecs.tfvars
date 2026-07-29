aws_region             = "us-east-1"
vpc_cidr               = "10.20.0.0/16"
public_subnet_cidrs    = ["10.20.1.0/24", "10.20.2.0/24"]
private_subnet_cidrs   = ["10.20.101.0/24", "10.20.102.0/24"]
container_image        = "nginx:latest"
container_port         = 80
execution_role_arn     = "arn:aws:iam::123456789012:role/ecsExecutionRole"
task_role_arn          = "arn:aws:iam::123456789012:role/ecsTaskRole"
alb_security_group_ids = ["sg-0123456789abcdef0"]
route53_zone_id        = "Z0123456789ABCDEF"
route53_record_name    = "uat.example.com"
route53_target         = "uat-alb-1234567890.us-east-1.elb.amazonaws.com"
tags = {
  Environment = "uat"
  Project     = "vip-migration"
}
