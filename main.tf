resource "libvirt_volume" "this_volume" {
  name             = var.name
  pool             = var.pool
  source           = var.image_source
  size             = var.size
  base_volume_id   = var.base_volume_id
  base_volume_name = var.base_volume_name
  base_volume_pool = var.base_volume_pool
}
