# Provider info in root module config

resource "pihole_dns_record" "record" {
  domain = var.dns_record
  ip     = var.ip
}