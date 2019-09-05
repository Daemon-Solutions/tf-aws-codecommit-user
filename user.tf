resource "aws_iam_user" "user" {
  name = var.user_name
  path = "/"
}

resource "aws_iam_user_ssh_key" "user" {
  username   = aws_iam_user.user.name
  encoding   = "PEM"
  public_key = var.user_key
}
