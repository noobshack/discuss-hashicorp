variable "subnet_ids" {
  type    = list
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}


variable "whitelist" {
  type    = list
  default = ["us-east-1a", "us-east-1d"]
}
