variable "domain" {
  type = string
}

variable "hostname" {
  type    = string
  default = "cdn"
}

variable "http_version" {
  type    = string
  default = "http2and3"
}

variable "min_tls_version" {
  type    = string
  default = "TLSv1.2_2021"
}