resource "aws_iam_user" "user" {
  name = var.user_name
  path = "/"
}

resource "aws_iam_user_ssh_key" "user" {
  username   = aws_iam_user.user.name
  encoding   = regex("^ssh-|.", var.user_key) == "ssh-" ? "SSH" : "PEM"
  public_key = var.user_key
}
