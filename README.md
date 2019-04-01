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

## Tools

You can add a tools node, which consists of some software that can be used for Rancher tooling like notifiers and logging. See below for more information on the current software included:

Note: replace PRIVATE_IP or PUBLIC_IP with tools-private-ip or tools-public-ip

| Software  | Endpoint | View command |
| ------------- | ------------- | ---------- |
| ElasticSearch | http://PRIVATE_IP:9200 | `docker logs elasticsearch` |
| Kibana  | http://PUBLIC_IP:5601  | `docker logs kibana` |
| SMTP (Mailhog) | http://PRIVATE_IP:1025 | `docker logs mailhog` |
| Echo server for HTTP requests | http://PRIVATE_IP:8080 | `docker logs echo` |
| Syslog (Syslog-NG) | http://PRIVATE_IP:514 | `docker logs syslog` |
| Fluentd | http://PRIVATE_IP:24224 | `docker logs fluentd` |

## How to use

- Clone this repository
- Move the file `terraform.tfvars.example` to `terraform.tfvars` and edit (see inline explanation)
- Run `terraform apply`
