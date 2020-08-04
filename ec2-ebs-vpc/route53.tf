resource "aws_route53_zone" "tf-poc-r53-zone" {
  name = "thetminko.com"
}

# dns reccord
resource "aws_route53_record" "tf-poc-r53-record" {
  name    = "tf.thetminko.com"
  zone_id = aws_route53_zone.tf-poc-r53-zone.zone_id
  type    = "A"
  ttl     = "300"
  records = [aws_eip.tf-poc-eip.public_ip]
}

output "ns-servers" {
  value = aws_route53_zone.tf-poc-r53-zone.name_servers
}
