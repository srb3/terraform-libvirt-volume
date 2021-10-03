# terraform-libvirt-volume

A terraform module for creating libvirt storage volumes

## Usage

The following code will create two storage volumes. First it
sets up a base volume based on an operating system disk image.
Then as a second step a main volume is created based of the
operating system base image.
This method allows many domains to share the same base image
and avoids duplication

```HCL
resource "random_id" "random" {
  byte_length = 4
}

locals {
  base_volume_name         = "base-test-${random_id.random.hex}"
  base_volume_pool         = "default"
  base_volume_image_source = "https://cloud-images.ubuntu.com/releases/groovy/release/ubuntu-20.10-server-cloudimg-amd64-disk-kvm.img"
  main_volume_name         = "main-test-${random_id.random.hex}"
  main_volume_pool         = "default"
  main_volume_size         = 40000000000
}

module "libvirt_domain_base" {
  source       = "srb3/volume/libvirt"
  name         = local.base_volume_name
  pool         = local.base_volume_pool
  image_source = local.base_volume_image_source
}

module "libvirt_domain_main" {
  source           = "srb3/volume/libvirt"
  name             = local.main_volume_name
  pool             = local.main_volume_pool
  size             = local.main_volume_size
  base_volume_name = local.base_volume_name
  base_volume_pool = local.base_volume_pool
  depends_on       = [module.libvirt_domain_base]
}
```

## Testing

This module uses [cinc-auditor](https://cinc.sh/start/auditor/) as a test framework.
To install you can use the [download page](https://cinc.sh/download/) and the
[getting started guid](https://cinc.sh/start/auditor/). The auditor test are
located in the [test --> integration directory](./test/integration).
There is a [make file](./Makefile)
in the root of the repo that takes care of orchestrating the tests
