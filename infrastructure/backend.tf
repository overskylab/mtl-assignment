terraform {
  # Do not use local state in production
  backend "local" {
    path = "terraform.tfstate"
  }
}
