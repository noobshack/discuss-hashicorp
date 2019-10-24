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

resource "null_resource" "main" {
  for_each = toset([for subnet in var.subnet_ids : matchkeys(var.whitelist, subnet)])
  #count = toset([for subnet in var.subnet_ids : contains(var.whitelist, subnet)])

  provisioner "local-exec" {
    command = "echo each.value"
  }
}
