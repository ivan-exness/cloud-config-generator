# cloud-config-generator
iPXE Cloud config Generator for Rancher Nodes

Install DHCPD with next config:
```
allow booting;
allow bootp;

default-lease-time 600;

max-lease-time 7200;
log-facility local7;

if exists user-class and option user-class = "iPXE" {
  next-server 10.10.10.1;
  filename "rancher.ipxe";
}

subnet 10.10.10.0 netmask 255.255.255.0 {
  range 10.10.10.100 10.10.10.254;
  option routers 10.10.10.1;
  option domain-name-servers 192.168.168.3;
}

host rancher-node-01 {
  hardware ethernet 00:50:56:8a:0c:bf;
  fixed-address 10.10.10.11;
}

host rancher-node-02 {
  hardware ethernet 00:50:56:8a:50:d4;
  fixed-address 10.10.10.12;
}

host rancher-node-03 {
  hardware ethernet 00:50:56:8a:56:56;
  fixed-address 10.10.10.13;
}

host rancher-node-04 {
  hardware ethernet 00:50:56:8a:25:f1;
  fixed-address 10.10.10.14;
}

host rancher-node-05 {
  hardware ethernet 00:50:56:8a:4f:90;
  fixed-address 10.10.10.15;
}
```

install tftpd and put file into /var/lib/tftpd (in Ubuntu)

```
#!ipxe
# Boots RancherOS in Ramdisk with persistent storage on disk /dev/vda

# Location of Kernel/Initrd images
set base-url http://releases.rancher.com/os/latest

kernel ${base-url}/vmlinuz rancher.state.formatzero=true rancher.state.autoformat=[/dev/sda] rancher.password=xxxXXXxxx rancher.cloud_init.datasources=[url:https://rancho.somedomain.com/cloud-config?ip=${net0/ip}]

initrd ${base-url}/initrd

boot
```


