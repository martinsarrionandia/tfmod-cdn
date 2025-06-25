locals {
  fqdn         = "cdn.${var.domain}"
  allow-origin = var.allow-origin != null ? var.allow-origin : var.domain
}
