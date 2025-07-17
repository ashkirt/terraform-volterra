terraform {
          required_version = ">= 0.12.9, != 0.13.0"
        
          required_providers {
            volterra = {
              source = "volterraedge/volterra"
              version = ">=0.10.0"
            }
          }
        }


variable "VES_tenant_url" {
  description = "Tenant URL for Volterra provider"
  type        = string
}


# Use the file in provider
provider "volterra" {
  api_p12_file = "/home/terraform/api.p12"
  url          = var.VES_tenant_url
}

