module "main" {
  source       = "../.."
  description  = "${var.name} Flow Control Policy."
  name         = var.name
  organization = "terratest"
  priority     = "auto"
  receive      = "Disabled"
  send         = "Disabled"
}
