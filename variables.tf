variable "domain" {
  type = string
}

variable "http-version" {
  type    = string
  default = "http3"
}

variable "min-tls-version" {
  type    = string
  default = "TLSv1.2_2021"
}