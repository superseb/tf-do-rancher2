# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

variable "do_token" {
  default = "xxx"
}

variable "prefix" {
  default = "yourname"
}

variable "rancher_version" {
  default = "v2.0.6"
}

variable "count_agent_all_nodes" {
  default = "3"
}

variable "count_agent_etcd_nodes" {
  default = "0"
}

variable "count_agent_controlplane_nodes" {
  default = "0"
}

variable "count_agent_worker_nodes" {
  default = "0"
}

variable "admin_password" {
  default = "admin"
}

variable "cluster_name" {
  default = "custom"
}

variable "region_server" {
  default = "lon1"
}

variable "region_agent" {
  default = "lon1"
}

variable "size" {
  default = "s-2vcpu-4gb"
}

variable "docker_version_server" {
  default = "17.03"
}

variable "docker_version_agent" {
  default = "17.03"
}

variable "docker_root" {
  default = ""
}

variable "k8s_version" {
  default = ""
}


variable "image_server" {
  default = "ubuntu-16-04-x64"
}

variable "image_agent" {
  default = "ubuntu-16-04-x64"
}

variable "ssh_keys" {
  default = []
}

resource "digitalocean_droplet" "rancherserver" {
  count     = "1"
  image     = "${var.image_server}"
  name      = "${var.prefix}-rancherserver"
  region    = "${var.region_server}"
  size      = "${var.size}"
  user_data = "${data.template_file.userdata_server.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "rancheragent-all" {
  count     = "${var.count_agent_all_nodes}"
  image     = "${var.image_agent}"
  name      = "${var.prefix}-rancheragent-${count.index}-all"
  region    = "${var.region_agent}"
  size      = "${var.size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "rancheragent-etcd" {
  count     = "${var.count_agent_etcd_nodes}"
  image     = "${var.image_agent}"
  name      = "${var.prefix}-rancheragent-${count.index}-etcd"
  region    = "${var.region_agent}"
  size      = "${var.size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "rancheragent-controlplane" {
  count     = "${var.count_agent_controlplane_nodes}"
  image     = "${var.image_agent}"
  name      = "${var.prefix}-rancheragent-${count.index}-controlplane"
  region    = "${var.region_agent}"
  size      = "${var.size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

resource "digitalocean_droplet" "rancheragent-worker" {
  count     = "${var.count_agent_worker_nodes}"
  image     = "${var.image_agent}"
  name      = "${var.prefix}-rancheragent-${count.index}-worker"
  region    = "${var.region_agent}"
  size      = "${var.size}"
  user_data = "${data.template_file.userdata_agent.rendered}"
  ssh_keys  = "${var.ssh_keys}"
}

data "template_file" "userdata_server" {
  template = "${file("files/userdata_server")}"

  vars {
    admin_password        = "${var.admin_password}"
    cluster_name          = "${var.cluster_name}"
    docker_version_server = "${var.docker_version_server}"
    docker_root           = "${var.docker_root}"
    rancher_version       = "${var.rancher_version}"
    k8s_version           = "${var.k8s_version}"
  }
}

data "template_file" "userdata_agent" {
  template = "${file("files/userdata_agent")}"

  vars {
    admin_password       = "${var.admin_password}"
    cluster_name         = "${var.cluster_name}"
    docker_version_agent = "${var.docker_version_agent}"
    docker_root          = "${var.docker_root}"
    rancher_version      = "${var.rancher_version}"
    server_address       = "${digitalocean_droplet.rancherserver.ipv4_address}"
  }
}

output "rancher-url" {
  value = ["https://${digitalocean_droplet.rancherserver.ipv4_address}"]
}
