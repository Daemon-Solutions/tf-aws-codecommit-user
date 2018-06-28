# tf-aws-codecommit-user

CodeCommit User - Terraform Module

Creates an IAM user with SSH read/write access to defined repositories in the account.

## Usage

```js
module "cc-user" {
  source      = "git::ssh://git@gogs.bashton.net/Bashton-Terraform-Modules/tf-aws-codecommit-user.git"

  user_name   = "mike"
  user_key    = "ssh-rsa AAAA<snip/>== mike@bashton.com"

  write_repos = "${aws_codecommit_repository.repo-1.arn}"
  read_repos  = "${aws_codecommit_repository.repo-2.arn}"
}
```

## Variables

Variables marked with an * are mandatory, the others have sane defaults and can be omitted.

- `user_name`* - Name of the IAM user
- `user_key`* - User's public SSH key
- `write_repos`- ARN(s) of repositories to grant write access to
- `read_repos`- ARN(s) of repositories to grant read access to


## Outputs

 - `user_key_id` - The unique identifier for the SSH public key

# TODO

 - Multi-user support using maps
