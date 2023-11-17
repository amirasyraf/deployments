# Worklow for terragrunt executions

Workflow that is used to run pre-commit checks and terragrunt plan and terragrunt apply based on trigger.

## Workflow description

Name: Terragrunt execution

Actions performed:
- Checkout current repository
- Configure AWS cli - to use specific role during GitHub -> AWS connection
- Install asdf tool - used to install all other tools
- Install all other tools with specified version based on .tool-versions
- Setup Git credentials
 - Run pre-commit checks
 - Execute terragrunt run-all plan or apply (based on worklflow event)

Triggers:
- On 'PullRequest' to 'main' branch: precommit-checks && terragrunt plan
- On 'push' to 'main' branch: terragrunt apply
- Manual: precommit-checks && terragrunt plan

```
EXAMPLE:
  PERSONAL_ACCESS_TOKEN: $PAT_VALUE
  AWS_ARN_ROLE_OIDC_MASTER: arn:aws:iam::ACCOUND_ID:role/ROLE_NAME
```
