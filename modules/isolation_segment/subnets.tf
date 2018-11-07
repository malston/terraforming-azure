resource "azurerm_subnet" "iso_seg_subnet" {
  name  = "${var.environment}-iso-seg-subnet-${element(var.iso_seg_names, count.index)}"
  count = "${var.count}"

  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${var.network_name}"
  address_prefix            = "${element(var.iso_seg_subnet_blocks, count.index)}"
}

resource "azurerm_subnet_network_security_group_association" "iso_seg_subnet_network_security_group_association" {
  count = "${var.count}"

  subnet_id                 = "${azurerm_subnet.iso_seg_subnet.*.id[count.index]}"
  network_security_group_id = "${var.bosh_deployed_vms_security_group_id}"
}
