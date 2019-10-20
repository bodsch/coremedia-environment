# instance the provider

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_network" "vm_network" {
  name      = "vm_network"
  domain    = "cm.local"
  addresses = [ "192.168.124.0/24" ]

  dns {
    enabled = true
    local_only = true
  }
}

# base system
resource "libvirt_volume" "base_vol" {
  name  = "lvm-centos"
  pool   = "default"
  source = "/var/lib/libvirt/images/CentOS-7-x86_64-GenericCloud-1907.qcow2"
}

output "image_bucket_name" {
  value = "${lookup(var.server_database, "disk_size", "")}"
}

# clone from base system and resize ...
resource "libvirt_volume" "cm-database-qcow2" {
  name           = "cm-${var.server_database["hostname"]}.qcow2"
  base_volume_id = "${libvirt_volume.base_vol.id}"
  pool           = "opt-share"
  size           = "${lookup(var.server_database, "disk_size", "") == "" ? "0" : var.server_database["disk_size"] }"
}

resource "libvirt_volume" "cm-backend-qcow2" {
  name           = "cm-${var.server_backend["hostname"]}.qcow2"
  base_volume_id = "${libvirt_volume.base_vol.id}"
  pool           = "opt-share"
  size           = "${var.server_backend["disk_size"]}"
}

resource "libvirt_volume" "cm-frontend-qcow2" {
  name           = "cm-${var.server_frontend["hostname"]}.qcow2"
  base_volume_id = "${libvirt_volume.base_vol.id}"
  pool           = "opt-share"
  size           = "${var.server_frontend["disk_size"]}"
}

resource "libvirt_volume" "cm-delivery-qcow2" {
  name           = "cm-${var.server_delivery["hostname"]}.qcow2"
  base_volume_id = "${libvirt_volume.base_vol.id}"
  pool           = "opt-share"
  size           = "${var.server_delivery["disk_size"]}"
}


# Use CloudInit to add our ssh-key to the instance
resource "libvirt_cloudinit_disk" "commoninit" {
  name       = "commoninit.iso"
  pool       = "opt-share"
  user_data  = "${data.template_file.user_data.rendered}"
}

data "template_file" "user_data" {
  template = "${file("${path.module}/cloud_init.cfg")}"
}

# Create the machine
resource "libvirt_domain" "cm-database" {
  name   = "${var.server_database["hostname"]}"
  memory = "${var.server_database["memory"]}"
  vcpu   = "${var.server_database["vcpu"]}"

  cloudinit = "${libvirt_cloudinit_disk.commoninit.id}"

  network_interface {
    network_id = "${libvirt_network.vm_network.id}"

    hostname  = "${var.server_database["hostname"]}"
    addresses = [ "${var.server_database["ip"]}" ]
    wait_for_lease = 1
  }

  # IMPORTANT
  # Ubuntu can hang is a isa-serial is not present at boot time.
  # If you find your CPU 100% and never is available this is why
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = "${libvirt_volume.cm-database-qcow2.id}"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}

resource "libvirt_domain" "cm-backend" {
  name   = "${var.server_backend["hostname"]}"
  memory = "${var.server_backend["memory"]}"
  vcpu   = "${var.server_backend["vcpu"]}"

  cloudinit = "${libvirt_cloudinit_disk.commoninit.id}"

  network_interface {
    network_id = "${libvirt_network.vm_network.id}"

    hostname  = "${var.server_backend["hostname"]}"
    addresses = [ "${var.server_backend["ip"]}" ]
    wait_for_lease = 1
  }

  # IMPORTANT
  # Ubuntu can hang is a isa-serial is not present at boot time.
  # If you find your CPU 100% and never is available this is why
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = "${libvirt_volume.cm-backend-qcow2.id}"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}

resource "libvirt_domain" "cm-frontend" {
  name   = "${var.server_frontend["hostname"]}"
  memory = "${var.server_frontend["memory"]}"
  vcpu   = "${var.server_frontend["vcpu"]}"

  cloudinit = "${libvirt_cloudinit_disk.commoninit.id}"

  network_interface {
    network_id = "${libvirt_network.vm_network.id}"

    hostname = "cm-frontend"
    hostname  = "${var.server_frontend["hostname"]}"
    addresses = [ "${var.server_frontend["ip"]}" ]
    wait_for_lease = 1
  }

  # IMPORTANT
  # Ubuntu can hang is a isa-serial is not present at boot time.
  # If you find your CPU 100% and never is available this is why
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = "${libvirt_volume.cm-frontend-qcow2.id}"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}

resource "libvirt_domain" "cm-delivery" {
  name   = "${var.server_delivery["hostname"]}"
  memory = "${var.server_delivery["memory"]}"
  vcpu   = "${var.server_delivery["vcpu"]}"

  cloudinit = "${libvirt_cloudinit_disk.commoninit.id}"

  network_interface {
    network_id = "${libvirt_network.vm_network.id}"

    hostname  = "${var.server_delivery["hostname"]}"
    addresses = [ "${var.server_delivery["ip"]}" ]
    wait_for_lease = 1
  }

  # IMPORTANT
  # Ubuntu can hang is a isa-serial is not present at boot time.
  # If you find your CPU 100% and never is available this is why
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = "${libvirt_volume.cm-delivery-qcow2.id}"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}