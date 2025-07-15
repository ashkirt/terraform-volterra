terraform {
          required_version = ">= 0.12.9, != 0.13.0"
        
          required_providers {
            volterra = {
              source = "volterraedge/volterra"
              version = ">=0.10.0"
            }
          }
        }
        provider "volterra" {
          VES_P12_CONTENT = var.VES_P12_CONTENT
          VES_P12_PASSWORD = var.VES_P12_PASSWORD
          url = var.VES_tenant_url
          
        }
