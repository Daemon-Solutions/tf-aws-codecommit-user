variable "user_name" {
  description = "The username for the user to create"
  type        = string
}

variable "user_key" {
  description = "The key for the user to create"
  type        = string
}

variable "write_repos" {
  description = "ARNs of the repositories to grant write access"
  type        = list(string)
  default     = []
}

variable "read_repos" {
  description = "ARNs of the repositories to grant read access"
  type        = list(string)
  default     = []
}

variable "random_byte_length" {
  description = "The byte length of the random id generator used for unique resource names."
  type        = number
  default     = 4
}
