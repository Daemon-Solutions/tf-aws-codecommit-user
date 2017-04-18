resource "aws_iam_user" "user" {
  name = "${var.user_name}"
  path = "/"
}

resource "aws_iam_user_policy_attachment" "codecommitrw-attach" {
  count = "${var.read_only ? 0 : 1}"

  user       = "${aws_iam_user.user.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
}

resource "aws_iam_user_policy_attachment" "codecommitro-attach" {
  count = "${var.read_only ? 1 : 0}"

  user       = "${aws_iam_user.user.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitReadOnlyAccess"
}

resource "aws_iam_user_policy_attachment" "iamssh-attach" {
  user       = "${aws_iam_user.user.name}"
  policy_arn = "arn:aws:iam::aws:policy/IAMUserSSHKeys"
}

resource "aws_iam_user_policy_attachment" "iamro-attach" {
  user       = "${aws_iam_user.user.name}"
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

resource "aws_iam_user_ssh_key" "user" {
  username   = "${aws_iam_user.user.name}"
  encoding   = "PEM"
  public_key = "${var.user_key}"
}
