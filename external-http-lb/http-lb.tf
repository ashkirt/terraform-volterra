//==========================================================================
//Definition of the Origin
//Start of the TF file
resource "volterra_origin_pool" "asingla-test-pool" {
  name                   = "asingla-test-pool"
  //Name of the namespace where the origin pool must be deployed
  namespace              = "shape-cs"
  origin_servers {

    public_ip {
      ip = "54.152.165.236"
    }

    labels = {
    }
  }

  no_tls = true
  port = 80
  endpoint_selection     = "LOCALPREFERED"
  loadbalancer_algorithm = "LB_OVERRIDE"
}
//End of the file
//==========================================================================

//Definition of the WAAP Policy
resource "volterra_app_firewall" "asingla-waap-new" {
  name      = "asingla-waap-new"
  namespace = "shape-cs"

  // One of the arguments from this list "allow_all_response_codes allowed_response_codes" must be set
  allow_all_response_codes = true
  // One of the arguments from this list "default_anonymization custom_anonymization disable_anonymization" must be set
  default_anonymization = true
  // One of the arguments from this list "use_default_blocking_page blocking_page" must be set
  use_default_blocking_page = true
  // One of the arguments from this list "default_bot_setting bot_protection_setting" must be set
  default_bot_setting = true
  // One of the arguments from this list "default_detection_settings detection_settings" must be set
  default_detection_settings = true
  // One of the arguments from this list "use_loadbalancer_setting blocking monitoring" must be set
  use_loadbalancer_setting = true
  // Blocking mode - optional - if not set, policy is in MONITORING
  blocking = true
}

//==========================================================================
//Definition of the Load-Balancer
//Start of the TF file
resource "volterra_http_loadbalancer" "asingla-http-new-lb" {
  depends_on = [volterra_origin_pool.asingla-test-pool]
  //Mandatory "Metadata"
  name      = "asingla-http-new-lb"
  //Name of the namespace where the origin pool must be deployed
  namespace = "shape-cs"
  //End of mandatory "Metadata" 
  //Mandatory "Basic configuration" with Auto-Cert 
  domains = ["juiceshop.asingla.life"]
  default_route_pools {
      pool {
        name = "asingla-test-pool"
        namespace = "shape-cs"
      }
      weight = 1
    }
  http {
    port = 80
   }
  enable_malicious_user_detection = true
  //Mandatory "VIP configuration"
  advertise_on_public_default_vip = true
  //End of mandatory "VIP configuration"
  //Mandatory "Security configuration"
  no_service_policies = true
  //service_policies_from_namespace = true
  no_challenge = true
  disable_rate_limit = true
  //WAAP Policy reference, created earlier in this plan - refer to the same name
  app_firewall {
    name = "asingla-waap-new"
    namespace = "shape-cs"
  }

  enable_api_discovery {
    enable_learn_from_redirect_traffic = true
  }

  enable_ip_reputation {
    ip_threat_categories = ["SPAM_SOURCES"]
  }

  data_guard_rules {
    metadata {
      name    = "default-rule"
      disable = false
    }
    apply_data_guard = true
    any_domain       = true
    path {
      prefix = "/"
    }
  }
  
  multi_lb_app = true
  user_id_client_ip = true
  //End of mandatory "Security configuration"
  //Mandatory "Load Balancing Control"
  source_ip_stickiness = true
  //End of mandatory "Load Balancing Control"
  
}

//End of the file
//==========================================================================
