variable user_name {
  desciption = "The username for the user to create"
  type = "string"
}

variable user_key {
  desciption = "The key for the user to create"
  type = "string"
}

variable read_only {
  desciption = "Bool indicating whether the user has readonly access"
  type = "string"
  default = true
}
