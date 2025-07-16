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
          api_cert = var.VES_API_CERT
          api_key = var.VES_API_KEY
          url = var.VES_tenant_url    
        }
