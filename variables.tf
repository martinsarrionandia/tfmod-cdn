variable "domain" {
  type = string
}

variable "hostname" {
  type    = string
  default = "cdn"
}

variable "http-version" {
  type    = string
  default = "http2and3"
}

variable "min-tls-version" {
  type    = string
  default = "TLSv1.2_2021"
}