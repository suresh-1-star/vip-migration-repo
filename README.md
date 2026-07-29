# vip-migration-repo

Terraform repository scaffold for a multi-environment AWS architecture with CI/CD automation.

## Structure

- terraform/bootstrap/: foundational Terraform for remote state resources
- terraform/modules/: reusable Terraform modules for VPC, ECS computing, ALB, target groups, and Route 53
- terraform/environments/: application stacks and environment entrypoints
- .github/workflows/: CI/CD pipeline definition

## Environments

- staging
- uat
- production

Each environment contains an ECS-specific tfvars file for deployment inputs.
