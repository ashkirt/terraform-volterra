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
          api_p12_file = base64decode(var.VES_p12_certificate_content)
          url = var.VES_tenant_url
        }
