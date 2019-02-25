resource "aws_iam_policy" "write_access" {
  count       = "${local.write_repos_enabled}"
  name        = "cc-write-${random_id.id.hex}"
  description = "CodeCommit write policy for user ${var.user_name}"
  path        = "/"
  policy      = "${element(data.aws_iam_policy_document.write_access_doc.*.json, count.index)}"
}

data "aws_iam_policy_document" "write_access_doc" {
  count = "${local.write_repos_enabled}"

  statement {
    effect = "Allow"

    actions = [
      "codecommit:*",
    ]

    resources = ["${var.write_repos}"]
  }
}

resource "aws_iam_policy_attachment" "write_access_attach" {
  count      = "${local.write_repos_enabled}"
  name       = "cc-write-attach-${random_id.id.hex}"
  users      = ["${aws_iam_user.user.name}"]
  policy_arn = "${element(aws_iam_policy.write_access.*.arn, count.index)}"
}

resource "aws_iam_policy" "write_access_policy" {
  count       = "${local.write_repos_enabled}"
  name        = "cc-write-access-policy-${random_id.id.hex}"
  description = "CodeCommit Cloudwatch policy for user ${var.user_name}"
  path        = "/"
  policy      = "${element(data.aws_iam_policy_document.write_access_policy_doc.*.json, count.index)}"
}

data "aws_iam_policy_document" "write_access_policy_doc" {
  count = "${local.write_repos_enabled}"

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
  count      = "${local.write_repos_enabled}"
  name       = "cc-write-access-policy-attach-${random_id.id.hex}"
  users      = ["${aws_iam_user.user.name}"]
  policy_arn = "${element(aws_iam_policy.write_access_policy.*.arn, count.index)}"
}

resource "aws_iam_policy" "read_access" {
  count       = "${local.read_repos_enabled}"
  name        = "cc-read-${random_id.id.hex}"
  description = "CodeCommit read policy for user ${var.user_name}"
  path        = "/"
  policy      = "${element(data.aws_iam_policy_document.read_access_doc.*.json, count.index)}"
}

data "aws_iam_policy_document" "read_access_doc" {
  count = "${local.read_repos_enabled}"

  statement = {
    effect = "Allow"

    actions = [
      "codecommit:BatchGet*",
      "codecommit:Get*",
      "codecommit:Describe*",
      "codecommit:List*",
      "codecommit:GitPull",
    ]

    resources = ["${var.read_repos}"]
  }
}

resource "aws_iam_policy_attachment" "read_access_attach" {
  count      = "${local.read_repos_enabled}"
  name       = "cc-read-attach-${random_id.id.hex}"
  users      = ["${aws_iam_user.user.name}"]
  policy_arn = "${element(aws_iam_policy.read_access.*.arn, count.index)}"
}

data "aws_iam_policy_document" "read_access_policy_doc" {
  count = "${local.read_repos_enabled}"

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
  count       = "${local.read_repos_enabled}"
  name        = "cc-read-access-policy-${random_id.id.hex}"
  description = "CodeCommit CloudWatch read policy for user ${var.user_name}"
  path        = "/"
  policy      = "${element(data.aws_iam_policy_document.read_access_policy_doc.*.json, count.index)}"
}

resource "aws_iam_policy_attachment" "read_access_policy_attach" {
  count      = "${local.read_repos_enabled}"
  name       = "cc-read-access-policy-${random_id.id.hex}"
  users      = ["${aws_iam_user.user.name}"]
  policy_arn = "${element(aws_iam_policy.read_access_policy.*.arn, count.index)}"
}
