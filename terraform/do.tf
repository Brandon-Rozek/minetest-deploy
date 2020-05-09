provider "digitalocean" {
    token = var.do_token
}

data "digitalocean_ssh_key" laptop {
    name = var.key_name
}

data "digitalocean_droplet_snapshot" "packer_snapshot" {
    name = "packer-docker"
    most_recent = true
}

# Create a droplet
resource "digitalocean_droplet" "web" {
    name = "tf-1"
    image = data.digitalocean_droplet_snapshot.packer_snapshot.id
    region = var.region
    size = var.size
    ssh_keys = [data.digitalocean_ssh_key.laptop.id]
    backups = false
}

# Attach a subdomain
resource "digitalocean_record" "www" {
  domain = var.domain
  type   = "A"
  name   = var.subdomain
  value  = digitalocean_droplet.web.ipv4_address
}

output "ip" {
    value = digitalocean_droplet.web.ipv4_address
}

output "domain" {
    value = "${digitalocean_record.www.name}.${digitalocean_record.www.domain}"
}
