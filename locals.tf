locals {
  fqdn         = "cdn.${var.domain}"
  allow-origin = var.allow-origin != null ? "https://${var.allow-origin}" : "https://${var.domain}"
}
