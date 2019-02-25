resource "aws_iam_user" "user" {
  count = "${var.enabled}"
  name  = "${var.user_name}"
  path  = "/"
}

resource "aws_iam_user_ssh_key" "user" {
  count      = "${var.enabled}"
  username   = "${aws_iam_user.user.name}"
  encoding   = "${var.key_encoding}"
  public_key = "${var.user_key}"
}
