# Baking AMIs

We use [Packer](https://www.packer.io/) with [Jenkins](https://wiki.jenkins-ci.org/display/JENKINS/Packer+Plugin) to bake AMIs automatically.

## Prerequisites

Create an **AWS IAM Role** with name `packer-ec2` and attach managed policy **AmazonS3ReadOnlyAccess**.

Configure the **EC2 Instance Profile** if you are running packer on EC2. Otherwise configure `~/.aws/credentials` on your machine.

## Build Ubuntu AMI
```shell
packer build \
    -var 'region=cn-northwest-1' \
    -var 'subnet_id=subnet_12345' \
    templates/ubuntu
```
## Build Ubuntu-CUDA AMI
```shell
packer build \
    -var 'region=cn-northwest-1' \
    -var 'subnet_id=subnet_12345' \
    -var 'source_ami_owners=[123456789]' \
    templates/ubuntu-cuda/
```
