terraform {
  required_version = ">= 0.12.0"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "noobshack"

    workspaces {
      name = "silver"
    }
  }
}

resource "tfe_workspace" "silver" {
  count = terraform.workspace == "default" ? 1 : 0

  name                  = "silver"
  organization          = "noobshack"
  auto_apply            = false
  terraform_version     = "0.12.10"

  operations        = var.remote_execution == true ? true : false
}
