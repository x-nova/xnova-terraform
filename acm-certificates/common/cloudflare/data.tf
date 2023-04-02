data "cloudflare_zones" "novawallet_zones" {
  filter {
    name = var.domain
  }
}
