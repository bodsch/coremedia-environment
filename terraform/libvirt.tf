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


resource "libvirt_volume" "base_vol" {
  name = "lvm-centos"
  pool = "default"
  source = "/var/lib/libvirt/images/CentOS-7-x86_64-GenericCloud-1907.qcow2"
}

resource "libvirt_volume" "cm-database-qcow2" {
  name = "cm-database.qcow2"
  base_volume_id = "${libvirt_volume.base_vol.id}"
  pool = "opt-share"
  # Size in bytes (20 GB)
  # size = 21474836480
  # Size in bytes (10 GB)
  size = 10737418240
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
  name = "cm-database"
  memory = "1024"
  vcpu = 1

  cloudinit = "${libvirt_cloudinit_disk.commoninit.id}"

  network_interface {
    network_id = "${libvirt_network.vm_network.id}"

    hostname = "cm-database"
    addresses = [ "192.168.124.10" ]
    mac = "AA:BB:CC:11:22:22"
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


