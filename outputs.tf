output "user_key_id" {
  value = "${element(concat(aws_iam_user_ssh_key.user.*.ssh_public_key_id, list("")), 0)}"
}
