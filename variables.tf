variable "domain" {
  type = string
}

variable "allow-origin" {
  type = string
}

variable "http-version" {
  type    = string
  default = "http2and3"
}

variable "min-tls-version" {
  type    = string
  default = "TLSv1.2_2021"
}