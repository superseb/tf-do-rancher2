# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

variable "do_token" {
  default = "xxx"
}

variable "prefix" {
  default = "yourname"
}

variable "rancher_version" {
  default = "v2.6.6"
}

variable "audit_level" {
  default = 0
}

variable "rancher_args" {
  default = ""
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

variable "count_tools_nodes" {
  default = "0"
}

variable "count_rke2_agent_all_nodes" {
  default = "0"
}

variable "count_rke2_agent_etcd_nodes" {
  default = "0"
}

variable "count_rke2_agent_controlplane_nodes" {
  default = "0"
}

variable "count_rke2_agent_worker_nodes" {
  default = "0"
}

variable "admin_password" {
  default = "admin"
}

variable "cluster_name" {
  default = "custom"
}

variable "cluster_rke2_name" {
  default = "rke2custom"
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

variable "all_size" {
  default = "s-2vcpu-4gb"
}

variable "etcd_size" {
  default = "s-2vcpu-4gb"
}

variable "controlplane_size" {
  default = "s-2vcpu-4gb"
}

variable "worker_size" {
  default = "s-2vcpu-4gb"
}

variable "tools_size" {
  default = "s-4vcpu-8gb"
}

variable "docker_version_server" {
  default = "20.10"
}

variable "docker_version_agent" {
  default = "20.10"
}

variable "docker_root" {
  default = ""
}

variable "k8s_version" {
  default = ""
}

variable "k8s_rke2_version" {
  default = ""
}

variable "image_server" {
  default = "ubuntu-20-04-x64"
}

variable "image_agent" {
  default = "ubuntu-20-04-x64"
}

variable "image_tools" {
  default = "ubuntu-20-04-x64"
}

variable "user_server" {
  default = "root"
}

variable "user_agent" {
  default = "root"
}

variable "user_tools" {
  default = "root"
}

variable "kernel_nf_conntrack_max" {
  default = "131072"
}

variable "ssh_keys" {
  default = []
}

data "digitalocean_account" "do-account" {
}

resource "digitalocean_droplet" "rancherserver" {
  count              = "1"
  image              = var.image_server
  name               = "${var.prefix}-rancherserver"
  private_networking = true
  region             = var.region_server
  size               = var.size
  user_data          = data.template_file.userdata_server.rendered
  ssh_keys           = var.ssh_keys
  tags               = [join("",["user:",replace(split("@",data.digitalocean_account.do-account.email)[0],".","-")])]
}

resource "digitalocean_droplet" "rancheragent-all" {
  count              = var.count_agent_all_nodes
  image              = var.image_agent
  name               = "${var.prefix}-rancheragent-all-${count.index}"
  private_networking = true
  region             = var.region_agent
  size               = var.all_size
  user_data          = data.template_file.userdata_agent.rendered
  ssh_keys           = var.ssh_keys
  tags               = [join("",["user:",replace(split("@",data.digitalocean_account.do-account.email)[0],".","-")])]
}

resource "digitalocean_droplet" "rancheragent-etcd" {
  count              = var.count_agent_etcd_nodes
  image              = var.image_agent
  name               = "${var.prefix}-rancheragent-etcd-${count.index}"
  private_networking = true
  region             = var.region_agent
  size               = var.etcd_size
  user_data          = data.template_file.userdata_agent.rendered
  ssh_keys           = var.ssh_keys
  tags               = [join("",["user:",replace(split("@",data.digitalocean_account.do-account.email)[0],".","-")])]
}

resource "digitalocean_droplet" "rancheragent-controlplane" {
  count              = var.count_agent_controlplane_nodes
  image              = var.image_agent
  name               = "${var.prefix}-rancheragent-controlplane-${count.index}"
  private_networking = true
  region             = var.region_agent
  size               = var.controlplane_size
  user_data          = data.template_file.userdata_agent.rendered
  ssh_keys           = var.ssh_keys
  tags               = [join("",["user:",replace(split("@",data.digitalocean_account.do-account.email)[0],".","-")])]
}

resource "digitalocean_droplet" "rancheragent-worker" {
  count              = var.count_agent_worker_nodes
  image              = var.image_agent
  name               = "${var.prefix}-rancheragent-worker-${count.index}"
  private_networking = true
  region             = var.region_agent
  size               = var.worker_size
  user_data          = data.template_file.userdata_agent.rendered
  ssh_keys           = var.ssh_keys
  tags               = [join("",["user:",replace(split("@",data.digitalocean_account.do-account.email)[0],".","-")])]
}

resource "digitalocean_droplet" "rancher-tools" {
  count              = var.count_tools_nodes
  image              = var.image_tools
  name               = "${var.prefix}-rancher-tools-${count.index}"
  private_networking = true
  region             = var.region_agent
  size               = var.tools_size
  user_data          = data.template_file.userdata_tools.rendered
  ssh_keys           = var.ssh_keys
  tags               = [join("",["user:",replace(split("@",data.digitalocean_account.do-account.email)[0],".","-")])]
}

resource "digitalocean_droplet" "rancheragent-rke2-all" {
  count              = var.count_rke2_agent_all_nodes
  image              = var.image_agent
  name               = "${var.prefix}-rancheragent-rke2-all-${count.index}"
  private_networking = true
  region             = var.region_agent
  size               = var.all_size
  user_data          = data.template_file.userdata_rke2_agent.rendered
  ssh_keys           = var.ssh_keys
  tags               = [join("",["user:",replace(split("@",data.digitalocean_account.do-account.email)[0],".","-")])]
}

resource "digitalocean_droplet" "rancheragent-rke2-etcd" {
  count              = var.count_rke2_agent_etcd_nodes
  image              = var.image_agent
  name               = "${var.prefix}-rancheragent-rke2-etcd-${count.index}"
  private_networking = true
  region             = var.region_agent
  size               = var.etcd_size
  user_data          = data.template_file.userdata_rke2_agent.rendered
  ssh_keys           = var.ssh_keys
  tags               = [join("",["user:",replace(split("@",data.digitalocean_account.do-account.email)[0],".","-")])]
}

resource "digitalocean_droplet" "rancheragent-rke2-controlplane" {
  count              = var.count_rke2_agent_controlplane_nodes
  image              = var.image_agent
  name               = "${var.prefix}-rancheragent-rke2-controlplane-${count.index}"
  private_networking = true
  region             = var.region_agent
  size               = var.controlplane_size
  user_data          = data.template_file.userdata_rke2_agent.rendered
  ssh_keys           = var.ssh_keys
  tags               = [join("",["user:",replace(split("@",data.digitalocean_account.do-account.email)[0],".","-")])]
}

resource "digitalocean_droplet" "rancheragent-rke2-worker" {
  count              = var.count_rke2_agent_worker_nodes
  image              = var.image_agent
  name               = "${var.prefix}-rancheragent-rke2-worker-${count.index}"
  private_networking = true
  region             = var.region_agent
  size               = var.worker_size
  user_data          = data.template_file.userdata_rke2_agent.rendered
  ssh_keys           = var.ssh_keys
  tags               = [join("",["user:",replace(split("@",data.digitalocean_account.do-account.email)[0],".","-")])]
}


data "template_file" "userdata_server" {
  template = file("files/userdata_server")

  vars = {
    admin_password          = var.admin_password
    cluster_name            = var.cluster_name
    cluster_rke2_name       = var.cluster_rke2_name
    docker_version_server   = var.docker_version_server
    docker_root             = var.docker_root
    rancher_version         = var.rancher_version
    rancher_args            = var.rancher_args
    k8s_version             = var.k8s_version
    k8s_rke2_version        = var.k8s_rke2_version
    audit_level             = var.audit_level
    kernel_nf_conntrack_max = var.kernel_nf_conntrack_max
  }
}

data "template_file" "userdata_agent" {
  template = file("files/userdata_agent")

  vars = {
    admin_password       = var.admin_password
    cluster_name         = var.cluster_name
    docker_version_agent = var.docker_version_agent
    docker_root          = var.docker_root
    rancher_version      = var.rancher_version
    server_address       = digitalocean_droplet.rancherserver[0].ipv4_address
  }
}

data "template_file" "userdata_tools" {
  template = file("files/userdata_tools")

  vars = {
    docker_version_agent = var.docker_version_agent
  }
}

data "template_file" "userdata_rke2_agent" {
  template = file("files/userdata_rke2_agent")

  vars = {
    admin_password       = var.admin_password
    cluster_rke2_name    = var.cluster_rke2_name
    docker_version_agent = var.docker_version_agent
    docker_root          = var.docker_root
    rancher_version      = var.rancher_version
    server_address       = digitalocean_droplet.rancherserver[0].ipv4_address
  }
}

resource "local_file" "ssh_config" {
  content  = templatefile("${path.module}/files/ssh_config_template", {
    prefix                    = var.prefix
    rancherserver             = digitalocean_droplet.rancherserver[0].ipv4_address,
    rancheragent-all          = [for node in digitalocean_droplet.rancheragent-all: node.ipv4_address],
    rancheragent-etcd         = [for node in digitalocean_droplet.rancheragent-etcd: node.ipv4_address],
    rancheragent-controlplane = [for node in digitalocean_droplet.rancheragent-controlplane: node.ipv4_address],
    rancheragent-worker       = [for node in digitalocean_droplet.rancheragent-worker: node.ipv4_address],
    rancher-tools             = [for node in digitalocean_droplet.rancher-tools: node.ipv4_address],
    user-server               = var.user_server,
    user-agent                = var.user_agent,
    user-tools                = var.user_tools
  })
  filename = "${path.module}/ssh_config"
}

output "rancher-url" {
  value = ["https://${digitalocean_droplet.rancherserver[0].ipv4_address}"]
}

output "tools-private-ip" {
  value = [digitalocean_droplet.rancher-tools.*.ipv4_address_private]
}

output "tools-public-ip" {
  value = [digitalocean_droplet.rancher-tools.*.ipv4_address]
}
