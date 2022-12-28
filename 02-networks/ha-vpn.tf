# HA VPN Gateway
resource "google_compute_ha_vpn_gateway" "ha-vpn-shared-vpc-common" {
  region   = "asia-south1"
  name     = "ha-vpn-shared-vpc-common"
  network  = "shared-vpc-common"
  project = var.shared-services-project
}

resource "google_compute_router" "router-asia-south1" {
  name    = "router-asia-south1-common"
  project = var.shared-services-project
  region  = "asia-south1"
  network = module.shared-vpc-common.network_self_link
  bgp {
    asn = 64514
  }
}

resource "google_compute_vpn_tunnel" "tunnel1" {
  name = "ha-vpn-tunnel1"
  region  = "asia-south1"
  vpn_gateway = google_compute_ha_vpn_gateway.ha-vpn-shared-vpc-common.id
  peer_gcp_gateway = google_compute_ha_vpn_gateway.ha-vpn-env-dev-net.id
  shared_secret = "samplePassword1"
  router = google_compute_router.router-asia-south1.id
  vpn_gateway_interface = 0
}

resource "google_compute_vpn_tunnel" "tunnel2" {
  name = "ha-vpn-tunnel2"
  region  = "asia-south1"
  vpn_gateway = google_compute_ha_vpn_gateway.ha-vpn-shared-vpc-common.id
  peer_gcp_gateway = google_compute_ha_vpn_gateway.ha-vpn-env-dev-net.id
  shared_secret = "samplePassword2"
  router = google_compute_router.router-asia-south1.id
  vpn_gateway_interface = 1
}

resource "google_compute_router_interface" "router1_interface1" {
  name       = "router1-interface1"
  router     = google_compute_router.router-asia-south1.name
  region     = "asia-south1"
  ip_range   = "169.254.0.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel1.name
}

resource "google_compute_router_peer" "router1_peer1" {
  name                      = "router1-peer1"
  router                    = google_compute_router.router-asia-south1.name
  region     = "asia-south1"
  peer_ip_address           = "169.254.0.2"
  peer_asn                  = 64515
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router1_interface1.name
}

resource "google_compute_router_interface" "router1_interface2" {
  name       = "router1-interface2"
  router     = google_compute_router.router-asia-south1.name
  region     = "asia-south1"
  ip_range   = "169.254.1.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel2.name
}

resource "google_compute_router_peer" "router1_peer2" {
  name                      = "router1-peer2"
  router                    = google_compute_router.router-asia-south1.name
  region                    = "asia-south1"
  peer_ip_address           = "169.254.1.1"
  peer_asn                  = 64515
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router1_interface2.name
}

# HA VPN Gateway
resource "google_compute_ha_vpn_gateway" "ha-vpn-env-dev-net" {
  region   = "asia-south1"
  name     = "ha-vpn-env-dev-net"
  network  = "env-dev-vpc"
  project = "playground-dev-env01-6712"
}

resource "google_compute_router" "router-env-dev-net-as1" {
  name    = "router-env-dev-net-as1"
  project = "playground-dev-env01-6712"
  region  = "asia-south1"
  network = "env-dev-vpc"
  bgp {
    asn = 64515
  }
}

resource "google_compute_vpn_tunnel" "tunnel3" {
  name = "ha-vpn-tunnel3"
  region  = "asia-south1"
  project = "playground-dev-env01-6712"
  vpn_gateway = google_compute_ha_vpn_gateway.ha-vpn-env-dev-net.id
  peer_gcp_gateway = google_compute_ha_vpn_gateway.ha-vpn-shared-vpc-common.id 
  shared_secret = "samplePassword1"
  router = google_compute_router.router-env-dev-net-as1.id
  vpn_gateway_interface = 0
}

resource "google_compute_vpn_tunnel" "tunnel4" {
  name = "ha-vpn-tunnel4"
  region = "asia-south1"
  project = "playground-dev-env01-6712"
  vpn_gateway = google_compute_ha_vpn_gateway.ha-vpn-env-dev-net.id
  peer_gcp_gateway = google_compute_ha_vpn_gateway.ha-vpn-shared-vpc-common.id 
  shared_secret = "samplePassword2"
  router = google_compute_router.router-env-dev-net-as1.id
  vpn_gateway_interface = 1
}

resource "google_compute_router_interface" "router2_interface1" {
  name       = "router2-interface1"
  router     = google_compute_router.router-env-dev-net-as1.name
  region     = "asia-south1"
  project    = "playground-dev-env01-6712"
  ip_range   = "169.254.0.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel3.name
}

resource "google_compute_router_interface" "router2_interface2" {
  name       = "router2-interface2"
  router     = google_compute_router.router-env-dev-net-as1.name
  region     = "asia-south1"
  project    = "playground-dev-env01-6712"
  ip_range   = "169.254.1.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel4.name
}

resource "google_compute_router_peer" "router2_peer1" {
  name                      = "router2-peer1"
  router                    = google_compute_router.router-env-dev-net-as1.name
  region                    = "asia-south1"
  project    = "playground-dev-env01-6712"
  peer_ip_address           = "169.254.0.1"
  peer_asn                  = 64514
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router2_interface1.name
}

resource "google_compute_router_peer" "router2_peer2" {
  name                      = "router2-peer2"
  router                    = google_compute_router.router-env-dev-net-as1.name
  region                    = "asia-south1"
  project                   = "playground-dev-env01-6712"
  peer_ip_address           = "169.254.1.2"
  peer_asn                  = 64514
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router2_interface2.name
}