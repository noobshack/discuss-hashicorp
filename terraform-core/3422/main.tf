terraform {
  required_version = ">= 0.12.0"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "noobshack"

    workspaces {
      name = "discuss-hashicorp"
    }
  }
}

provider "cloudflare" {
  version = "~> 2.0"
  api_token = "${var.cloudflare_api_token}"
}

resource "cloudflare_record" "dns" {
  //count = var.enabled == true : 1 ? 0
  for_each = toset(var.records)

  zone_id = var.cloudflare_zone_id
  name    = "subdomain"
  value   = "${each.value}"
  type    = "CNAME"
  ttl     = 3600
}
