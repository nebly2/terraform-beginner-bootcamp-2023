# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging. 
[semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, e.g `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terrafirn CLI

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

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
https://en.wikipedia.org/wiki/Shebang_(Unix)
https://en.wikipedia.org/wiki/Chmod
https://www.gitpod.io/docs/configure/workspaces/workspace-lifecycle