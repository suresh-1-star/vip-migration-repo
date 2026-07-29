resource "aws_lb_target_group" "this" {
  name                 = var.name
  port                 = var.port
  protocol             = var.protocol
  vpc_id               = var.vpc_id
  target_type          = var.target_type
  deregistration_delay = var.deregistration_delay

  # ----------------------------------------------------------------------------
  # TSK-301 AUDIT COMPLIANT HEALTH CHECK CONFIGURATION
  # ----------------------------------------------------------------------------
  health_check {
    enabled             = var.health_check_enabled
    path                = var.health_check_path     # TSK-301.1 (/health)
    protocol            = var.health_check_protocol # HTTP
    matcher             = var.health_check_matcher  # TSK-301.2 (200 OK)
    interval            = var.health_check_interval # TSK-301.3 (15s)
    timeout             = var.health_check_timeout  # TSK-301.3 (5s)
    healthy_threshold   = var.healthy_threshold     # TSK-301.4 (2 successes)
    unhealthy_threshold = var.unhealthy_threshold   # TSK-301.4 (3 failures)
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags,
    {
      Name        = var.name
      ManagedBy   = "Terraform"
      AuditTicket = "TSK-301"
    }
  )
}