# Worklow for terragrunt executions

Workflow that is used to run pre-commit checks and terragrunt plan and terragrunt apply based on trigger.

## Workflow description

Name: Terragrunt execution ( terragrunt-executions.yaml )

Actions performed:
- Checkout current repository
- Configure AWS cli - to use specific role during GitHub -> AWS connection
- Install asdf tool - used to install all other tools
- Install all other tools with specified version based on [.tools-versions](https://github.com/maksystem-platform/landing-zone/blob/main/.tool-versions)
- Setup Git credentials - needed to allow access to private repositories like maksystem-mirrors
 - Run pre-commit checks
 - Execute terragrunt run-all plan or apply (based on worklflow event)

Triggers:
- On 'PullRequest' to 'main' branch: precommit-checks && terragrunt plan
- On 'push' to 'main' branch: terragrunt apply
- Manual: precommit-checks && terragrunt plan

Configuration (global-one-time):
- Create secrets: PERSONAL_ACCESS_TOKEN and AWS_ARN_ROLE_OIDC_MASTER, on repository from where WF is defined.

PERSONAL_ACCESS_TOKEN needs to be created from account that has access to all private repositories on maksystem organizations.

AWS_ARN_ROLE_OIDC_MASTER used for Github -> AWS communication

```
EXAMPLE:
  PERSONAL_ACCESS_TOKEN: $PAT_VALUE
  AWS_ARN_ROLE_OIDC_MASTER: arn:aws:iam::ACCOUND_ID:role/ROLE_NAME
```
