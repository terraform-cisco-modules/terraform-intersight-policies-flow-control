#____________________________________________________________
#
# Intersight Organization Data Source
# GUI Location: Settings > Settings > Organizations > {Name}
#____________________________________________________________

data "intersight_organization_organization" "org_moid" {
  for_each = {
    for v in [var.organization] : v => v if length(
      regexall("[[:xdigit:]]{24}", var.organization)
    ) == 0
  }
  name = each.value
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
  priority_flow_control_mode = var.priority
  receive_direction          = var.receive
  send_direction             = var.send
  organization {
    moid = length(
      regexall("[[:xdigit:]]{24}", var.organization)
      ) > 0 ? var.organization : data.intersight_organization_organization.org_moid[
      var.organization].results[0
    ].moid
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
