# Terraform Beginner Bootcamp 2023

## Table of Contents
- [Semantic Versioning](#semantic-versioning-mage)
- [Install the terraform CLI](#install-the-terraform-cli)
- [Consideration for Linux Distribution](#consideration-for-linux-distribution)
- [Refactoring into Bash scripts](#refactoring-into-bash-scripts)
- [Shebang](#shebang)
- [Execution Considerations](#execution-considerations)
- [Linux Considerations](#linux-considerations)
- [Github Lifecycle (before, init, Command)](#github-lifecycle-before-init-command)
- [Working with env vars](#working-with-env-vars)
- [Printing vars](#printing-vars)
- [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging. 
[semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, e.g `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Consideration with the Terraform CLI changes
The Terraform CLI installation instructions have chanaged due to gpg keyring changes. So the original gitpod.yml bash so we meeded refer to the latest install CLI instriction via Terraform documentation.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Consideration for Linux Distribution 

This project is built against Ubuntu. 
Please conside checking your Linux Dsitribution and change accordingly to distribution needs 
[How to check OS verision in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version
```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```


### Refactoring into Bash scripts

While fixing the Terraform CLI gpg deprication inssue, we a bash script to install Terraform CLI. 
- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy
- Allows easier debugging and manual execution of Terrraform CLI install 

Bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

### Shebang 
https://en.wikipedia.org/wiki/Shebang_(Unix)

A shebang tells the bash script what program that will interpret the script. eg. `#!/bin/bash`

ChatGPT recommended this format `#!/bin/bash/env bash`

-For portability for different OS distributions 
- Will search the user's path for bash executable

#### Execution Considerations

When executing the bash script we can see use `./` shorthand notiation to execute the bash script

eg. `./bin/install_terraform_cli`
If we are using .gitpod.yml we need to point the script to a program to interpret it

eg. `source ./bin/install_terraform_cli`

#### Linux Considerations 
In order to make our bash scripts executable we need to change linux permision for the file to be executale at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

### Github Lifecycle (before, init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/workspace-lifecycle

### Working with env vars

We can list all Enviroment Variables (Env vars) using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env vars 

In the terminal we can set using `export HELLO= 'world'`
In the terminal we unset using `unset HELLO`
We can set an  env var temporarly when just running a command 

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without sriting export eg.

```sh
#!/usr/bin/env bash
Hello= 'world'

echo $HELLO
```

## Printing vars

We can print an env var using echo eg. 'echo $HELLO'

#### Scoping of Env Vars
 
 When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

 If you wnat to Env vars to persis across all future bash terminals that are open you need to set env vars in you bash profile eg. `.bash_profile`

 #### Persisting Env vars in Gitpod 

 We can persist env vars into gitpod by storing them in Gitpod Secret Storage. 

 ```
 gp env HELLO='world'
 ```

 All future workspaces launced will set the env vars for all bash terminals opened in all worspaces.

 ### AWS CLI Installation 

 AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

 [Getting started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

 [AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly by running the following AWS command
```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload return that looks like this:
```json
{
    "UserId": "AIDARLQTDTPAQTJ56Q2NW",
    "Account": "093457834057",
    "Arn": "arn:aws:iam::093457834057:user/terraform-beginner-bootcamp"
}
```

## Need to generate AWS CLI credential from IAM user in order to utilize the AWS CLI

-Create AWS root user account
-Through root account, you can create an IAM user with admin credentials
-Through the IAM admin account, you can create AWL CLI access keys through IAM console

## Terraform Basics
### Terraform Registry

Terraform sources their providers and modules from the Terraform Registry which located at [registry.terraform.io](https://registry.terraform.io/)

-**Provider** is an interaface to APIs that will allow you to create resources in Terraform
[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest)

-**Modules** is a way to make a loarge amnount of terraform code modular, portable, and shareable.

### Terraform Console

We can list all Terraform commands with `terraform`

#### Terraform init

To start a new Terraform project, you have to run `terraform init` to download binaries for the terraform providers that we'll use in this project/

#### Terraform PLan

This will generate a changeset, about the state of our infrastructure and what will be changes. 

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply

`terraform apply`

This will run the plan and pass the changeset to be excuted by terraform. Apply should prompt yes or no.

If you want to auto approve, you can provide an auto approve flag eg. `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`
This will destory resources. You also use auto approve flags such as `terraform destroy --auto-approve`

## Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File should be commited to your Version Control System (VSC) eg. Github

### Terraform State files

`.terraform.tfstate` contains information about the current shtate of you infrastructure.

This file **should no be commited** to your VCS

This file can contain sensitive data. 

If you lose this file, you lose knowing the state of you infrastructure.

`.terraform.tfstate.backup` is teh previous state file state.

### Terraform Directory

`.terrform` directory contains binaries of terraform providers. 

## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch bash a wiswig view to generate a token. However it does not work expected in Gitpod VScode in browser.
The workaround is to manually generate a token in Terraform Cloud.

```
https://app.terraform.io/app/settings/tokens
```

Then create the file manually here: 

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
```

Then open the file manually 
```sh
open /home/gitpod/.terraform.d/credentials.tfrc.json
```
Provide the following code ("replace with token in file")

```json
{
    "credentials": {
        "app.terraform.io": {
            "token": "ENTER_TOKEN"
        }
    }
}
```

Automated the process by created a bash script [bin/generate_tfrc_credentials](./bin/generate_tfrc_credentials)