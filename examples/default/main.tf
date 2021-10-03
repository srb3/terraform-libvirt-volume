provider "libvirt" {
  uri = "qemu:///system"
}

resource "random_id" "random" {
  byte_length = 4
}

locals {
  base_volume_name         = "base-test-${random_id.random.hex}"
  base_volume_pool         = "default"
  base_volume_image_source = "https://cloud-images.ubuntu.com/releases/hirsute/release/ubuntu-21.04-server-cloudimg-amd64-disk-kvm.img"
  main_volume_name         = "main-test-${random_id.random.hex}"
  main_volume_pool         = "default"
  main_volume_size         = 40000000000
}

module "libvirt_domain_base" {
  source       = "../../"
  name         = local.base_volume_name
  pool         = local.base_volume_pool
  image_source = local.base_volume_image_source
}

module "libvirt_domain_main" {
  source           = "../../"
  name             = local.main_volume_name
  pool             = local.main_volume_pool
  size             = local.main_volume_size
  base_volume_name = local.base_volume_name
  base_volume_pool = local.base_volume_pool
  depends_on       = [module.libvirt_domain_base]
}

########### Testing data #########################

# The local variables and the module below are
# used to generate test data for this example.
# They are not needed for the core libvirt
# functionality
locals {
  attributes = {
    expected_base_volume_name = local.base_volume_name
    expected_base_volume_pool = local.base_volume_pool
    expected_main_volume_name = local.main_volume_name
    expected_main_volume_pool = local.main_volume_pool
    expected_main_volume_size = local.main_volume_size
  }
}

module "attributes" {
  source     = "../test_attributes"
  data       = yamlencode(local.attributes)
  test_suite = "default"
}
