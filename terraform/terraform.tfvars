
# Size in bytes (20 GB)
# size = 21474836480
# Size in bytes (10 GB)
# size = 10737418240

server_database = {
  "memory"    = 2048
  "vcpu"      = 1
  "disk_size" = ""
  "ip"        = "192.168.124.10"
  "hostname"  = "database"
}

server_backend = {

  "memory"    = 512
  "vcpu"      = 1
  "disk_size" = "10737418240"
  "ip"        = "192.168.124.20"
  "hostname"  = "backend"
}

server_frontend = {
  "memory"    = 512
  "vcpu"      = 1
  "disk_size" = "10737418240"
  "ip"        = "192.168.124.30"
  "hostname"  = "frontend"
}

server_delivery = {
  "memory"    = 512
  "vcpu"      = 1
  "disk_size" = "10737418240"
  "ip"        = "192.168.124.35"
  "hostname"  = "delivery"
}