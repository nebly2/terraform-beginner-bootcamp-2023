# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### Terraform Cloud Variables

You are able to set two kinds of variables in terraform:
- Enviorment Variables - set in your bash terminal e.g. AWS credentials
- Terraform Variables - those that your would normally set in the tfvars file

Can set Terraform cloud variables as sensitive so they are not shown.

### Loading Terraform Variables

We can use the `-var` flag to set and input variable or ovveride a variable in the tfvars file eg. `terroform -var user_uuid="my-user_id"`

### var-file flag

### terraform.tfvars

This is the default file to load in terrform variables in bulk

### auto.tfvars

### order of terraform variables



## Terraform Import

## Dealing with Configurantion Drift

## What happens if we lose our state file?

If you lose your statefile, you most likeyly have to tear down all your cloud infrastructure manually.

You can use terraform port but it won't for all cloud resources. You need to check with the terraform providers documentation for which resources support import. 

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.example`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps.

If we run Terraform plan is with attempt to put our infrastructure back into the expected state fixing Configuration Drift.