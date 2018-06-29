resource "aws_iam_policy" "write_access" {
  count = "${length(var.write_repos) >= 1 ? 1 : 0}"

  name = "cc-write-${random_id.id.hex}-${count.index}"
  path = "/"

  policy = "${data.aws_iam_policy_document.write_access_doc.json}"
}

data "aws_iam_policy_document" "write_access_doc" {

  statement {
    effect = "Allow"

    actions = [
      "codecommit:*",
    ]

    resources = [
      "${var.write_repos}",
    ]
  }
}

resource "aws_iam_policy_attachment" "write_access_attach" {
  count = "${length(var.write_repos) >= 1 ? 1 : 0}"

  name       = "cc-write-attach-${random_id.id.hex}-${count.index}"
  users      = ["${aws_iam_user.user.name}"]
  policy_arn = "${aws_iam_policy.write_access.arn}"
}

resource "aws_iam_policy" "write_access_policy" {
  count = "${length(var.write_repos) >= 1 ? 1 : 0}"

  name = "cc-write-access-policy-${random_id.id.hex}"
  path = "/"

  policy = "${data.aws_iam_policy_document.write_access_policy_doc.json}"
}

data "aws_iam_policy_document" "write_access_policy_doc" {

  statement = {
    sid    = "CloudWatchEventsCodeCommitRulesAccess"
    effect = "Allow"

    actions = [
      "events:DeleteRule",
      "events:DescribeRule",
      "events:DisableRule",
      "events:EnableRule",
      "events:PutRule",
      "events:PutTargets",
      "events:RemoveTargets",
      "events:ListTargetsByRule",
    ]

    resources = [
      "arn:aws:events:*:*:rule/codecommit*",
    ]
  }

  statement {
    sid    = "SNSTopicAndSubscriptionAccess"
    effect = "Allow"

    actions = [
      "sns:CreateTopic",
      "sns:DeleteTopic",
      "sns:Subscribe",
      "sns:Unsubscribe",
      "sns:SetTopicAttributes",
    ]

    resources = [
      "arn:aws:sns:*:*:codecommit*",
    ]
  }

  statement {
    sid    = "SNSTopicAndSubscriptionReadAccess"
    effect = "Allow"

    actions = [
      "sns:ListTopics",
      "sns:ListSubscriptionsByTopic",
      "sns:GetTopicAttributes",
    ]

    resources = [
      "*",
    ]
  }

  statement = {
    sid    = "LambdaReadOnlyListAccess"
    effect = "Allow"

    actions = [
      "lambda:ListFunctions",
    ]

    resources = [
      "*",
    ]
  }

  statement = {
    sid    = "IAMReadOnlyListAccess"
    effect = "Allow"

    actions = [
      "iam:ListUsers",
    ]

    resources = [
      "*",
    ]
  }

  statement = {
    sid    = "IAMReadOnlyConsoleAccess"
    effect = "Allow"

    actions = [
      "iam:ListAccessKeys",
      "iam:ListSSHPublicKeys",
      "iam:ListServiceSpecificCredentials",
      "iam:ListAccessKeys",
      "iam:GetSSHPublicKey",
    ]

    resources = [
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }

  statement = {
    sid    = "IAMUserSSHKeys"
    effect = "Allow"

    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey",
    ]

    resources = [
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }

  statement = {
    sid    = "IAMSelfManageServiceSpecificCredentials"
    effect = "Allow"

    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ResetServiceSpecificCredential",
    ]

    resources = [
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }
}

resource "aws_iam_policy_attachment" "write_access_policy_attach" {
  count = "${length(var.write_repos) >= 1 ? 1 : 0}"

  name       = "cc-write-access-policy-attach-${random_id.id.hex}"
  users      = ["${aws_iam_user.user.name}"]
  policy_arn = "${aws_iam_policy.write_access_policy.arn}"
}

resource "aws_iam_policy" "read_access" {
  count = "${length(var.read_repos) >= 1 ? 1 : 0}"

  name = "cc-read-${random_id.id.hex}-${count.index}"
  path = "/"

  policy = "${data.aws_iam_policy_document.read_access_doc.json}"
}

data "aws_iam_policy_document" "read_access_doc" {

  statement = {
    effect = "Allow"

    actions = [
      "codecommit:BatchGet*",
      "codecommit:Get*",
      "codecommit:Describe*",
      "codecommit:List*",
      "codecommit:GitPull",
    ]

    resources = [
      "${var.read_repos}",
    ]
  }
}

resource "aws_iam_policy_attachment" "read_access_attach" {
  count = "${length(var.read_repos) >= 1 ? 1 : 0}"

  name       = "cc-read-attach-${random_id.id.hex}-${count.index}"
  users      = ["${aws_iam_user.user.name}"]
  policy_arn = "${aws_iam_policy.read_access.arn}"
}

data "aws_iam_policy_document" "read_access_policy_doc" {

  statement = {
    sid    = "CloudWatchEventsCodeCommitRulesReadOnlyAccess"
    effect = "Allow"

    actions = [
      "events:DescribeRule",
      "events:ListTargetsByRule",
    ]

    resources = [
      "arn:aws:events:*:*:rule/codecommit*",
    ]
  }

  statement = {
    sid    = "SNSSubscriptionAccess"
    effect = "Allow"

    actions = [
      "sns:ListTopics",
      "sns:ListSubscriptionsByTopic",
      "sns:GetTopicAttributes",
    ]

    resources = [
      "*",
    ]
  }

  statement = {
    sid    = "LambdaReadOnlyListAccess"
    effect = "allow"

    actions = [
      "lambda:ListFunctions",
    ]

    resources = [
      "*",
    ]
  }

  statement = {
    sid    = "IAMReadOnlyListAccess"
    effect = "allow"

    actions = [
      "iam:ListUsers",
    ]

    resources = [
      "*",
    ]
  }

  statement = {
    sid    = "IAMReadOnlyConsoleAccess"
    effect = "Allow"

    actions = [
      "iam:ListAccessKeys",
      "iam:ListSSHPublicKeys",
      "iam:ListServiceSpecificCredentials",
      "iam:ListAccessKeys",
      "iam:GetSSHPublicKey",
    ]

    resources = [
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }
}

resource "aws_iam_policy" "read_access_policy" {
  count = "${length(var.read_repos) >= 1 ? 1 : 0}"

  name = "cc-read-access-policy-${random_id.id.hex}"
  path = "/"

  policy = "${data.aws_iam_policy_document.read_access_policy_doc.json}"
}

resource "aws_iam_policy_attachment" "read_access_policy_attach" {
  count = "${length(var.read_repos) >= 1 ? 1 : 0}"

  name       = "cc-read-access-policy-${random_id.id.hex}"
  users      = ["${aws_iam_user.user.name}"]
  policy_arn = "${aws_iam_policy.read_access_policy.arn}"
}
