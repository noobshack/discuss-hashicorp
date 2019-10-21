variable "cloudflare_api_token" {}
variable "cloudflare_zone_id" {}

variable "records" {
  default = ["terraform", "example", "third"]
  type = list
}

variable "enabled" {
  default = true
  type = bool
}
