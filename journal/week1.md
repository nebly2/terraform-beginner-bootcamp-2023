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

## Fixing using Terraform Refresh 

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

It is recommended to place modules in a `modules` directory when locally developing modules but you can name it whatever you like. 

### Passing Input Variables

We can pass input variables to our module.

The modules has to declare the terraform varaibles in its own variables.tf
```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules)

Using the source we can import the modules from various places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

## Considerations when using ChatGPT to write Terrform 

LLMs such as ChatGPT may not be trained on the latest documentation or information about terraform.

It may likey produce older examples that could be deprecated. Often using affected providers.

## Working with Files in Terraform


### Fileexists function

This is a built in terraform function to checl the existance of a file.

```tf
condition     = fileexists(var.error_html_filepath)
```

### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path variable

In terraform there is a special varaible called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module 
[Special Path variable](https://developer.hashicorp.com/terraform/language/expressions/references)

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}

## Terraform Locals

Locals allow us to define local variable.
It can be very useful when we need transform data into another format and have referenced a varaible.

```tf
locals {
    s3_origin_id = "MyS3Origin"
}
```

[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

### Terraform Data Sources

This allows us to sourcce data from cloud resources.
This is useful when we want to reference cloud resources without importing them.

[Terraform Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

We use the jsonencode to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)
