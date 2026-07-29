# ------------------------------------------------------------------------------
# 1. APPLICATION LOAD BALANCER RESOURCE
# ------------------------------------------------------------------------------
resource "aws_lb" "this" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  tags = merge(
    var.tags,
    {
      Name      = var.name
      ManagedBy = "Terraform"
    }
  )
}

# ------------------------------------------------------------------------------
# 2. HTTP LISTENER (PORT 80) - A.1 TO A.4 AUDIT COMPLIANCE
# Permanent 301 Redirect preserving Host, Path, and Query parameters
# ------------------------------------------------------------------------------
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301" # Permanent Redirect
      host        = "#{host}"
      path        = "/#{path}"
      query       = "#{query}"
    }
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.name}-http-redirect"
      AuditTicket = "A.1-A.4"
    }
  )
}

# ------------------------------------------------------------------------------
# 3. HTTPS LISTENER (PORT 443) - FORWARDS TO TARGET GROUP
# ------------------------------------------------------------------------------
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.name}-https"
      AuditTicket = "TSK-401"
    }
  )
}