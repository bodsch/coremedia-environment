# infrastructure

## install terraform

https://computingforgeeks.com/how-to-install-terraform-on-ubuntu-centos-7/

## install terraform KVM provider

```
$ cd ~
$ terraform init
Terraform initialized in an empty directory!

$ mkdir -p ~/.terraform.d/plugins/linux_amd64

$ cd ~/.terraform.d/plugins/linux_amd64
$ curl -sL https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.6.0/terraform-provider-libvirt-0.6.0+git.1569597268.1c8597df.Ubuntu_18.04.amd64.tar.gz > terraform-provider-libvirt.tar.gz
$ tar -xzf terraform-provider-libvirt.tar.gz
$ ~/.terraform.d/plugins/linux_amd64/terraform-provider-libvirt -version
/home/bodsch/.terraform.d/plugins/linux_amd64/terraform-provider-libvirt 0.6.0+git.1569597268.1c8597df
Compiled against library: libvirt 4.0.0
Using library: libvirt 5.5.0
Running hypervisor: QEMU 4.0.0
Running against daemon: 5.5.0
```

## usage of this part

```
$ terraform init
Initializing provider plugins…

Terraform has been successfully initialized!
You may now begin working with Terraform. Try running "terraform plan" to see any changes that are required for your infrastructure. All Terraform commands should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

```
$ terraform plan


$ terraform apply [-auto-approve]


$ terraform show


$ terraform destroy [-auto-approve]

```

# download Cloud Image

```
$ cd /var/lib/libvirt/images
$ sudo curl -sL https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1907.qcow2.xz -o CentOS-7-x86_64-GenericCloud-1907.qcow2.xz
$ sudo xz -d CentOS-7-x86_64-GenericCloud-1907.qcow2.xz
```
