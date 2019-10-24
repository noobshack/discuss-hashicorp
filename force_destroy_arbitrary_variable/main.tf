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
  depends_on = [ null_resource.destroy_me ]

  provisioner "local-exec" {
    command = "terraform taint null_resource.destroy_me"
  }
}

resource "null_resource" "destroy_me" { }
