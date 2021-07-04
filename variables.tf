variable "name" {
  description = "A unique name for the resource, required by libvirt. Changing this forces a new resource to be created"
  type        = string
}

variable "pool" {
  description = "The storage pool where the resource will be created"
  type        = string
  default     = "default"
}

variable "image_source" {
  description = "If specified, the image will be uploaded into libvirt storage pool"
  type        = string
  default     = null
}

variable "size" {
  description = "The size of the volume in bytes, If source is specified, size will be set to the source image file size"
  type        = string
  default     = null
}

variable "base_volume_id" {
  description = "The backing volume (CoW) to use for this volume"
  type        = string
  default     = null
}

variable "base_volume_name" {
  description = "The name of the backing volume (CoW) to use for this volume"
  type        = string
  default     = null
}

variable "base_volume_pool" {
  description = "The name of the storage pool containing the volume defined by base_volume_name"
  type        = string
  default     = null
}
