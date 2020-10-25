terraform {
  backend "consul" {
    scheme = "http"
    path   = "remote-states/terraform/vpc-flow-logs-example.tfstate"
  }
}

