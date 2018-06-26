# Terraform config to launch Rancher 2.0

## Summary

This terraform setup will:

- Start a droplet running `rancher/rancher` version specified in `rancher_version`
- Create a custom cluster called `cluster_name`
- Start `count_agent_nodes` amount of droplets and add them to the custom cluster with all roles

## How to use

- Clone this repository
- Move the file `terraform.tfvars.example` to `terraform.tfvars` and edit (see inline explanation)
- Run `terraform apply`
