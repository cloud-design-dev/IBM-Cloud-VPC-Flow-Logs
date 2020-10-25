terraform {
  required_version = "0.13.5"

  required_providers {
    ibm = {
      source           = "IBM-Cloud/ibm"
      required_version = "1.13.1"
    }
  }
}
