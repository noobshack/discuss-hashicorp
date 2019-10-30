remote_state {
  backend = "remote"
  config = {
    hostname = ""
    organization = ""
    workspaces = {
      name = "discuss-hashicorp"
    }
  }
}
