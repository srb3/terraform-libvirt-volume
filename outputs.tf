output "name" {
  value = var.name
}

output "id" {
  value = libvirt_volume.this_volume.id
}
