
  # Size in bytes (20 GB)
  # size = 21474836480
  # Size in bytes (10 GB)
  # size = 10737418240

variable "server_monitoring" {
  type = "map"

  default = {
    "memory"    = 2048
    "vcpu"      = 1
    "disk_size" = "10737418240"
    "ip"        = "192.168.124.50"
    "hostname"  = "monitoring"
  }
}

variable "server_database" {
  type = "map"

  default = {
    "memory"    = 2048
    "vcpu"      = 1
    "disk_size" = ""
    "ip"        = "192.168.124.10"
    "hostname"  = "database"
  }
}

variable "server_backend" {
  type = "map"

  default = {
    "memory"    = 512
    "vcpu"      = 1
    "disk_size" = ""
    "ip"        = "192.168.124.20"
    "hostname"  = "backend"
  }
}

variable "server_frontend" {
  type = "map"

  default = {
    "memory"    = 512
    "vcpu"      = 1
    "disk_size" = ""
    "ip"        = "192.168.124.30"
    "hostname"  = "frontend"
  }
}

variable "server_delivery" {
  type = "map"

  default = {
    "memory"    = 512
    "vcpu"      = 1
    "disk_size" = ""
    "ip"        = "192.168.124.35"
    "hostname"  = "delivery"
  }
}
