variable "user_name" {
  description = "The username for the user to create"
  type        = "string"
}

variable "user_key" {
  description = "The key for the user to create"
  type        = "string"
}

variable "write_repos" {
  description = "ARNs of the repositories to grant write access"
  type        = "list"
  default     = []
}

variable "read_repos" {
  description = "ARNs of the repositories to grant read access"
  type        = "list"
  default     = []
}

variable "random_byte_length" {
  description = "The byte length of the random id generator used for unique resource names."
  default     = 4
}

variable "enabled" {
  description = "Enable or disable the module"
  default     = true
}

variable "key_encoding" {
  description = "Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM."
  default     = "SSH"
}

locals {
  write_repos_enabled = "${length(var.write_repos) > 0 && var.enabled ? 1 : 0}"
  read_repos_enabled  = "${length(var.read_repos) > 0 && var.enabled ? 1 : 0}"
}
