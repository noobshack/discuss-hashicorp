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

resource "null_resource" "subservice" {}
