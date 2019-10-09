provider "openstack" {
  user_name   = "admin"
  tenant_name = "admin"
  password    = "TZ1F8YBexEeDjzRiWpuUJENYjfGxF6PTHXs9DjQr"
  auth_url    = "http://192.168.1.50:35357/v3"
  region      = "RegionOne"
}

resource "openstack_compute_instance_v2" "k8s-master-01" {
  name            = "k8s-master-01"
  image_name      = "ubuntu-server-18.04-amd64"
  flavor_name       = "m1.medium"
  key_pair        = "ostack-lab-fof"
  security_groups = ["default"]

  metadata = {
    node = "k8s-master-01"
  }

  network {
    name = "demo-net"
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = "${openstack_compute_instance_v2.k8s-master-01.access_ip_v4}"
    private_key = file("${path.module}/ostack-lab-fof.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "uptime",
    ]
  }

}

resource "openstack_compute_instance_v2" "k8s-worker-01" {
  name            = "k8s-worker-01"
  image_name      = "ubuntu-server-18.04-amd64"
  flavor_name       = "m1.custom"
  key_pair        = "ostack-lab-fof"
  security_groups = ["default"]

  metadata = {
    node = "k8s-worker-01"
  }

  network {
    name = "demo-net"
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = "${openstack_compute_instance_v2.k8s-worker-01.access_ip_v4}"
    private_key = file("${path.module}/ostack-lab-fof.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "uptime",
    ]
  }

}

resource "openstack_compute_instance_v2" "k8s-worker-02" {
  name            = "k8s-worker-02"
  image_name      = "ubuntu-server-18.04-amd64"
  flavor_name       = "m1.custom"
  key_pair        = "ostack-lab-fof"
  security_groups = ["default"]

  metadata = {
    node = "k8s-worker-02"
  }

  network {
    name = "demo-net"
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = "${openstack_compute_instance_v2.k8s-worker-02.access_ip_v4}"
    private_key = file("${path.module}/ostack-lab-fof.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "uptime",
    ]
  }

}

output "k8s-master-01-ip" {
	value = openstack_compute_instance_v2.k8s-master-01.access_ip_v4
}

output "k8s-worker-01-ip" {
        value = openstack_compute_instance_v2.k8s-worker-01.access_ip_v4
}

output "k8s-worker-02-ip" {
        value = openstack_compute_instance_v2.k8s-worker-02.access_ip_v4
}
