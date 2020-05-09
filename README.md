# minetest-deploy
An example of how to use Packer and Terraform to deploy minetest onto DigitalOcean using its Docker Compose configuration.

First you need to change the `config` file to contain your digital ocean API token and your SSH key name.

Then go to the packer directory and run packer build
```bash
cd packer
packer build .
```

Then go to the terraform directory and deploy
```bash
cd terraform
terraform apply
```
