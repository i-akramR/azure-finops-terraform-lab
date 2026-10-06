# ---------------------------------------------------------
# Network Interface
# ---------------------------------------------------------

resource "azurerm_network_interface" "nic" {
  for_each = merge(
    var.windows_virtual_machines,
    var.linux_virtual_machines
  )

  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.snet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
  tags = var.common_tags
}


# ---------------------------------------------------------
# Windows Virtual Machine
# ---------------------------------------------------------

resource "azurerm_windows_virtual_machine" "vname" {
  for_each = var.windows_virtual_machines

  name                = each.value.vm_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  size                = each.value.size

  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  license_type = each.value.AHB ? "Windows_Server" : null

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  tags = var.common_tags
}


# ---------------------------------------------------------
# Linux Spot Virtual Machine
# ---------------------------------------------------------

resource "azurerm_linux_virtual_machine" "vname" {
  for_each = var.linux_virtual_machines

  name                = each.value.vm_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  size                = each.value.size

  admin_username = each.value.admin_username

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  admin_ssh_key {
    username   = each.value.admin_username
    public_key = each.value.ssh_public_key
  }

  priority        = each.value.priority
  eviction_policy = each.value.eviction_policy
  max_bid_price   = each.value.max_bid_price

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = var.common_tags
}
