resource_groups = {
  finops = {
    resource_group_name = "finops-dev-rg"
    location            = "Central India"

    tags = {
      Purpose = "FinOps Practice Lab"
    }
  }
}
virtual_networks = {
  hub = {
    name                = "finops-dev-vnet"
    location            = "Central India"
    resource_group_name = "finops-dev-rg"
    address_space       = ["10.198.0.0/16"]

    tags = {
      NetworkType = "Hub"
    }
  }
}
subnets = {
  app = {
    subnet_name         = "app-subnet"
    vnet_name           = "finops-dev-vnet"
    resource_group_name = "finops-dev-rg"
    address_prefixes    = ["10.198.1.0/24"]

    tags = {
      SubnetType = "App"
    }
  }

  data = {
    subnet_name         = "data-subnet"
    vnet_name           = "finops-dev-vnet"
    resource_group_name = "finops-dev-rg"
    address_prefixes    = ["10.198.2.0/24"]

    tags = {
      SubnetType = "Data"
    }
  }
}
windows_virtual_machines = {
  windows = {
    vm_name             = "finops-dev-win"
    vnet_name           = "finops-dev-vnet"
    subnet_name         = "app-subnet"
    location            = "Central India"
    resource_group_name = "finops-dev-rg"
    nic_name            = "finops-dev-win-nic"

    size     = "Standard_D2s_v5"
    priority = "Regular"

    license_type   = "Windows_Server"
    admin_username = "azureadmin"
    admin_password = "Akki@5636819"
    AHB            = true
  }
}

linux_virtual_machines = {
  spot = {
    vm_name             = "finops-dev-spot"
    vnet_name           = "finops-dev-vnet"
    subnet_name         = "data-subnet"
    location            = "Central India"
    resource_group_name = "finops-dev-rg"
    nic_name            = "finops-dev-spot-nic"

    size            = "Standard_D2als_v6"
    priority        = "Spot"
    eviction_policy = "Deallocate"
    max_bid_price   = -1

    admin_username = "azureadmin"
    ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCDXq3CxEtobSu2Y04IjNE5ovnsNlJi0JxS7KWrOXHgsw2RnFbsUpP1IOWxY1dDO1ZybsVODgn/pRBliN3vBM0jdrifLBsKHUXCHW5IQX3eyEU8fnwwEKOg23Cgq9ZHTRnj46grCg13mgcfLx48wQPnyQ8lBjJUaS0ee5y2LynuUmrJldEDvu0kVorxItzoXfVEpeO7pBcryI3LxVOaE+Os2xbMlvS+SwgboqeRcVS4yMpvMQCNj5hQHvvOirfEkZxp9Te7K4QrU0qwoOmV3Nfm3MQuGhrPMLeps/yN0mHGbXQfvUiNYb2dS+QZqkrCaLPoEF9SClOuEw3eHhJqnU7 hp@Akram"
  }
}
policies = {
  inherit_environment = {
    name                 = "inherit-environment"
    display_name         = "Inherit Environment tag from resource group"
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ea3f2387-9b95-492a-a190-fcdc54f7b070"

    resource_group_key = "finops"

    parameters = {
      tagName = {
        value = "Environment"
      }
    }
  }

  require_costcenter = {
    name                 = "require-costcenter"
    display_name         = "Require CostCenter tag on resources"
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"

    resource_group_key = "finops"

    parameters = {
      tagName = {
        value = "CostCenter"
      }
    }
  }
}


finops_alert_email = "akkiraza.ar@gmail.com"

cost_export = {
  storage_account_name = "finops5636819"
  resource_group_name  = "FinOps-RG"
  container_name       = "finops"
  export_name          = "finops-dev-daily-cost"

  start_date = "2026-10-05T00:00:00Z"
  end_date   = "2027-10-05T00:00:00Z"

  root_folder_path = "/finops"
}
