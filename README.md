# Terraform config to launch Rancher 2.0

## Summary

This Terraform setup will:

- Start a droplet running `rancher/rancher` version specified in `rancher_version`
- Create a custom cluster called `cluster_name`
- Start `count_agent_all_nodes` amount of droplets and add them to the custom cluster with all roles

### Optional adding nodes per role
- Start `count_agent_etcd_nodes` amount of droplets and add them to the custom cluster with etcd role
- Start `count_agent_controlplane_nodes` amount of droplets and add them to the custom cluster with controlplane role
- Start `count_agent_worker_nodes` amount of droplets and add them to the custom cluster with worker role

## Other options

All available options/variables are described in [terraform.tfvars.example](https://github.com/superseb/tf-do-rancher2/blob/master/terraform.tfvars.example).

## How to use

- Clone this repository
- Move the file `terraform.tfvars.example` to `terraform.tfvars` and edit (see inline explanation)
- Run `terraform apply`
