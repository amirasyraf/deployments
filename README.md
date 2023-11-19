# README

## Workflow Overview

The `deployments` repository contains all Terraform stack configuration in the form of `.hcl` files, which are used by Terragrunt, a Terraform wrapper that provides extra tools for keeping Terraform deployments DRY and other powerful features. This repository defines all the variables which are then passed as inputs to the actual Terraform codes located in the `terraform-modules` repository.

The GitHub Actions workflow, **.github/workflows/terragrunt-executions.yaml**, has two modes of operations: **terragrunt-plan** which runs `terragrunt run-all plan`, and **terragrunt-apply** which runs `terragrunt run-all apply`. 

**terragrunt-plan** is executed when a PR is raised against the **master** branch. This essentially runs a normal `terraform plan`, allowing the PR contributor and reviewers to review the changes. **terragrunt-apply** is only executed once the PR has been reviewed, approved, and merged.

### Architecture

![image](https://github.com/amirasyraf/deployments/assets/15522007/be863b92-639f-47f9-96d5-e0cad8413b0d)

1. GitHub Actions AKA workflow authenticates itself with AWS via OIDC authentication
2. Workflow then assumes into another role, **AWSControlTowerExecution**. Based on the `account_id` defined, this may be in accounts other than the sharedservices account
3. Terraform executes normally, by first checking for the existence of an S3 state bucket and DynamoDB table, of which it creates automatically if not found
4. Depending on the mode of operation states in the previous section, Terraform either runs a plan or an apply against the infrastructure

The steps above occurs simultaneously across all accounts defined in this repository, as Terragrunt automatically runs against all `terragrunt.hcl` configuration it finds. 

## Requirements

- AWS role with trust policy enabling access via OIDC - https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
- AWS role **AWSControlTowerExecution** - Should automatically be created as part of Control Tower account provisioning

## Usage

1. Clone this repository
2. Install all tools defined in the **.tool-versions** file. It is highly recommended to use https://asdf-vm.com/ as it simplifies management and installation of tools
3. Install pre-commit: `pre-commit install` - This will ensure pre-commit is run on every commit
4. To get started, copy an existing stack. For example, copy the VPC stack https://github.com/amirasyraf/deployments/tree/master/infra/ap-southeast-2/staging/vpc into another account, such as `preview`
5. Raise a PR
6. Wait for workflow to complete
7. Review the generated Terraform plan
