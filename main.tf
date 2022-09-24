#____________________________________________________________
#
# Intersight Organization Data Source
# GUI Location: Settings > Settings > Organizations > {Name}
#____________________________________________________________

data "intersight_organization_organization" "org_moid" {
  name = var.organization
}

#__________________________________________________________________
#
# Intersight Flow Control Policy
# GUI Location: Policies > Create Policy > Flow Control
#__________________________________________________________________

resource "intersight_fabric_flow_control_policy" "flow_control" {
  depends_on = [
    data.intersight_organization_organization.org_moid
  ]
  description                = var.description != "" ? var.description : "${var.name} Flow Control Policy."
  name                       = var.name
  priority_flow_control_mode = var.priority_flow_control_mode
  receive_direction          = var.receive_direction
  send_direction             = var.send_direction
  organization {
    moid        = data.intersight_organization_organization.org_moid.results[0].moid
    object_type = "organization.Organization"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
