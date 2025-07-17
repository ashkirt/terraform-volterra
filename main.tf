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
  
provisioner "remote-exec" {
    command = <<-EOT
      echo '${var.VES_API_P12_BASE64}' | base64 -d > api.p12
      chmod 600 api.p12
      echo "P12 file created at: $(pwd)/api.p12"
      ls -la api.p12
    EOT
  }
}


provider "volterra" {
  url          = var.VES_tenant_url
}


