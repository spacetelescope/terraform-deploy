# PANGEO Terraform Deploy

Opinionated deployment of PANGEO-style JupyterHub-ready infrastructure with [Terraform](https://www.terraform.io/). 

This particular branch is presented for use with the Medium blog post JupyterHub-Ready Infrastructure Deployment with Terraform on AWS (link?).

## Introduction

This repo is here to be an opintionated configuration and guide for deploying all the infrastructure necessary for a Pangeo-style JupyterHub. 

## Deployment Instructions

### AWS Setup

#### Install Terraform, dependencies, and this GitHub repo

You'll need the following tools installed:

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Helm](https://helm.sh/docs/intro/install/)

You will also need this branch of this repo. You can get it with:

```
git clone https://github.com/salvis2/terraform-deploy.git
cd terraform-deploy
git checkout -t origin/blog-post
```

#### Authenticate to AWS

You need to have the `aws` CLI configured to run correctly from your local machine - terraform will just read from the same source. The [documentation on configuring AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) should help.

This repo provides the `aws-creds` folder in case you do not have admin permissions or want to follow the principle of least privilege. By default (as in, what is uncommented), the folder gives you a new user named `terraform-bot` with policy attachments to run the Terraform commands in the `aws` folder. If you want to create this user, run the following:

```
cd aws-creds
terraform init
terraform apply
```

Terraform will prompt you for an `awscli` profile and a region here. The profile you want to use if probably `default`. IAM resources are global, so you can put in whatever region you want to create the rest of the resources in.

You will then have to configure `terraform-bot`'s credentials in the AWS Console. Go and generate access keys for the user, then put them into your command line with 

```
aws configure --profile terraform-bot
```

#### Configure your Infrastructure

The terraform deployment needs several variable names set before it can start. Run

```
cp your-cluster.tfvars.template <your-cluster>.tfvars
```

with your desired filename. You should supply a value for each variable listed in this file. If you don't know your AWS account ID offhand, you can find it with the command

```
aws sts get-caller-identity
```

#### Run terraform!

Once this is all done, you should:

- `cd aws`
- Run `terraform init` to set up appropriate plugins
- Run `terraform apply -var-file=<your-cluster>.tfvars`, referring to the `tfvars` file you made in step 3
- Type `yes` when prompted
- Wait patiently. The infrastructure can take 15 minutes or more to create. Sometimes you will get an error saying the Kubernetes cluster is unreachable. This is usually resolved by running the `terraform apply ...` command again. Tons of green output means the deployment was successful!

#### Test out your cluster!

If you want to take a peek at your cluster, you will need to tell `kubectl` and `Helm` where your cluster is, since Terraform doesn't modify them by default. Do this with the following command, filling in values for your deployment.

```
aws eks update-kubeconfig --name=<cluster-name> --region=<region> --profile=<profile>
```

Now you should be able to run local commands to inspect the cluster! Try the following:

```
aws eks list-clusters
aws eks describe-cluster --name=<cluster-name>
kubectl get pods -A
kubectl get nodes -A
helm list -A
```

#### Tear Down

If you don't want these resources on your account forever (since they cost you money), you can tear it all down with the following:

```
terraform destroy --var-file=<your-cluster>.tfvars
cd ../aws-creds/
terraform destroy
```

If you set your local kubeconfig to point to this cluster, you can remove that with the following:

```
kubectl config delete-cluster <your-cluster-arn>
kubectl config delete-context <your-cluster-context>
kubectl config unset users.<user-name>
```

You can get those variables with the corresponding commands:
- <your-cluster-arn>: `kubectl config get-clusters`
- <your-cluster-context>: `kubectl config get-contexts`
- <user-name>: `kubectl config view`, the name you want will look something like `arn:aws:eks:us-west-2:############:cluster/<your-cluster>`.

You may also want to set your `kubectl` context to be something else with

```
kubectl config use-context <different context>
```

