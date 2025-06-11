provider "aws" {
  region = "eu-west-1"
}

resource "aws_route53_zone" "jentz_co" {
  name    = "jentz.co"
  comment = "HostedZone created by Route53 Registrar"
  tags = {
    Project = "Common"
  }
}

resource "aws_route53_record" "jentz_co_mx" {
  name    = "jentz.co"
  ttl     = 300
  type    = "MX"
  zone_id = aws_route53_zone.jentz_co.zone_id
  records = [
    "10 in1-smtp.messagingengine.com.",
    "20 in2-smtp.messagingengine.com."
  ]
}

resource "aws_route53_record" "jentz_co_ns" {
  name            = "jentz.co"
  ttl             = 172800
  type            = "NS"
  zone_id         = aws_route53_zone.jentz_co.zone_id
  records = [
    "ns-1473.awsdns-56.org.",
    "ns-1983.awsdns-55.co.uk.",
    "ns-281.awsdns-35.com.",
    "ns-782.awsdns-33.net."
  ]
}

resource "aws_route53_record" "jentz_co_soa" {
  name            = "jentz.co"
  ttl             = 900
  type            = "SOA"
  zone_id         = aws_route53_zone.jentz_co.zone_id
  records         = ["ns-782.awsdns-33.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
}

resource "aws_route53_record" "jentz_co_txt" {
  name           = "jentz.co"
  ttl            = 300
  type           = "TXT"
  zone_id        = aws_route53_zone.jentz_co.zone_id
  records        = ["v=spf1 include:spf.messagingengine.com ?all"]
}

resource "aws_route53_record" "jentz_co_dkim1" {
  name    = "fm1._domainkey.jentz.co"
  ttl     = 300
  type    = "CNAME"
  zone_id = aws_route53_zone.jentz_co.zone_id
  records = ["fm1.jentz.co.dkim.fmhosted.com."]
}


resource "aws_route53_record" "jentz_co_dkim2" {
  name    = "fm2._domainkey.jentz.co"
  ttl     = 300
  type    = "CNAME"
  zone_id = aws_route53_zone.jentz_co.zone_id
  records = ["fm2.jentz.co.dkim.fmhosted.com."]
}

resource "aws_route53_record" "jentz_co_dkim3" {
  name    = "fm3._domainkey.jentz.co"
  ttl     = 300
  type    = "CNAME"
  zone_id = aws_route53_zone.jentz_co.zone_id
  records = ["fm3.jentz.co.dkim.fmhosted.com."]
}

# ACM Certificate for jentz.co
# Must be created in us-east-1 for CloudFront distribution
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_acm_certificate" "jentz_co" {
  provider          = aws.us_east_1
  domain_name       = "jentz.co"
  validation_method = "DNS"

  subject_alternative_names = [
    "www.jentz.co"
  ]

  tags = {
    Project = "Common"
  }
}

resource "aws_route53_record" "jentz_co_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.jentz_co.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.jentz_co.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "jentz_co" {
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.jentz_co.arn
  validation_record_fqdns = [for record in aws_route53_record.jentz_co_cert_validation : record.fqdn]
}
