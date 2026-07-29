# ------------------------------------------------------------------------------
# 1. ROUTE 53 PRIVATE HOSTED ZONE (TSK-201)
# ------------------------------------------------------------------------------
resource "aws_route53_zone" "private" {
  name = var.domain_name

  vpc {
    vpc_id = var.vpc_id
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.domain_name}-phz"
      AuditTicket = "TSK-201"
    }
  )
}

# ------------------------------------------------------------------------------
# 2. PRIMARY AWS CLOUD ALIAS RECORD (ecs.aws.emea.fedex.com)
# ------------------------------------------------------------------------------
resource "aws_route53_record" "aws_cloud_endpoint" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "ecs.aws.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# ------------------------------------------------------------------------------
# 3. CUTOVER CNAME (ecs.emea.fedex.com -> ecs.aws.emea.fedex.com)
# ------------------------------------------------------------------------------
resource "aws_route53_record" "main_cutover_cname" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "ecs.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300

  records = [aws_route53_record.aws_cloud_endpoint.name]
}

# ------------------------------------------------------------------------------
# 4. LEGACY ALIAS CNAMES FOR HARDCODED CLIENTS (NOS & DUB)
# ------------------------------------------------------------------------------
resource "aws_route53_record" "legacy_nos_cname" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "ecs-nos.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300

  records = [aws_route53_record.aws_cloud_endpoint.name]
}

resource "aws_route53_record" "legacy_dub_cname" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "ecs-dub.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300

  records = [aws_route53_record.aws_cloud_endpoint.name]
}