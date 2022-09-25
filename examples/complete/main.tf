module "flow_control" {
  source  = "terraform-cisco-modules/policies-flow-control/intersight"
  version = ">= 1.0.1"

  description  = "default Flow Control Policy."
  name         = "default"
  organization = "default"
  priority     = "auto"
  receive      = "Disabled"
  send         = "Disabled"
}
