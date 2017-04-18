# tf-aws-codecommit-user

CodeCommit User - Terraform Module

Creates an IAM user with SSH access to all CodeCommit repositories in the account.

## Usage

```js
module "cc-user" {
  source    = "git::ssh://git@gogs.bashton.net/Bashton-Terraform-Modules/tf-aws-codecommit-user.git"

  user_name = "mike"
  user_key  = "ssh-rsa AAAA<snip/>== mike@bashton.com"
  read_only = "false"
}
```

## Variables

Variables marked with an * are mandatory, the others have sane defaults and can be omitted.

- `user_name`* - Name of the IAM user
- `user_key`* - User's public SSH key
- `read_only` - (*default*: `false`) User's access level to the repositories


## Outputs

 - `user_key_id` - The unique identifier for the SSH public key

# TODO

 - Multi-user support using maps
 - Repository restrictions
