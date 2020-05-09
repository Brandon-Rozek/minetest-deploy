source "digitalocean" "web" {
  api_token = var.do_token
  image = var.base_system_image
  region = var.region
  size = var.size
  ssh_username = "root"
  snapshot_name = "packer-docker"
}


build {
  sources = [
    "source.digitalocean.web",
  ]

  provisioner "file" {
    source = "docker-compose.yml"
    destination = "/root/docker-compose.yml"
  }
  
  provisioner "file" {
    source = "docker-compose.service"
    destination = "/etc/systemd/system/docker-compose.service"
  }
  
  provisioner "shell" {
    scripts = [ "setup.sh" ]
  }
}
