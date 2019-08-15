---
layout: page
title: Create Systemd Service
permalink: /rc/
---

We need to automatically run some commands, such as load kernel modules, configure and start ovs daemons, and start faucet when the SDN switch is rebooted. 

Prior to systemd taking over as the default system on almost all Linuxes, you would add bash commands to `/etc/rc.local`. However this is no longer the correct approach.

Instead we have to create our script file and create systemd service unit to call our script. Finally we need to enable the systemd service.

### Create /usr/local/libexec/my-startup-script file

First create the `/usr/local/libexec/` folder for your script.

{% highlight bash %}
sudo mkdir /usr/local/libexec
{% endhighlight %}

Copy the following contents to the `/usr/local/libexec/my-startup-script` file.

{% highlight bash %}
#!/bin/bash

# Load kernel modules
modprobe vfio-pci
modprobe openvswitch

# Modify attributes for /dev/vfio
chmod a+x /dev/vfio
chmod 0666 /dev/vfio/*

# Bind Intel NIC PCI devices to vfio-pci driver
DPDK_DIR=/usr/src/dpdk-stable-18.11.1
$DPDK_DIR/usertools/dpdk-devbind.py --bind=vfio-pci \
        0000:03:00.0 0000:03:00.1 0000:04:00.0 0000:04:00.1

# Create openvswitch folder for db.sock communications
mkdir -p /var/run/openvswitch

# Start the ovsdb-server
ovsdb-server --remote=punix:/var/run/openvswitch/db.sock \
    --remote=db:Open_vSwitch,Open_vSwitch,manager_options \
    --private-key=db:Open_vSwitch,SSL,private_key \
    --certificate=db:Open_vSwitch,SSL,certificate \
    --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert \
    --pidfile --detach --log-file

# Configure the ovs-vsctl daemon
ovs-vsctl --no-wait set Open_vSwitch . \
        other_config:dpdk-init=true \
        other_config:dpdk-hugepage-dir=/dev/hugepages

# Start the ovs-vsctl daemon
/usr/share/openvswitch/scripts/ovs-ctl --no-ovsdb-server start
# /usr/share/openvswitch/scripts/ovs-ctl start

# Create the bridge br0
ovs-vsctl --may-exist add-br br0 -- set bridge br0 \
        datapath_type=netdev protocols=OpenFlow13

# Add the 4 dpdk ports to the bridge br0
ovs-vsctl --may-exist add-port br0 dpdk0 -- set interface dpdk0 \
        type=dpdk options:dpdk-devargs=0000:03:00.0
ovs-vsctl --may-exist add-port br0 dpdk1 -- set interface dpdk1 \
        type=dpdk options:dpdk-devargs=0000:03:00.1
ovs-vsctl --may-exist add-port br0 dpdk2 -- set interface dpdk2 \
        type=dpdk options:dpdk-devargs=0000:04:00.0
ovs-vsctl --may-exist add-port br0 dpdk3 -- set interface dpdk3 \
        type=dpdk options:dpdk-devargs=0000:04:00.1

# Set failure mode for the bridge
ovs-vsctl set-fail-mode br0 secure

# Set controller for the bridge
ovs-vsctl set-controller br0 tcp:127.0.0.1:6653

exit 0
{% endhighlight %}

Then run the following command

{% highlight bash %}
sudo chmod +x /usr/local/libexec/my-startup-script
{% endhighlight %}


### Create /etc/systemd/system/my-startup.service file

Copy the following contents to the `/etc/systemd/system/my-startup.service` file.

{% highlight bash %}
[Service]
 Type=oneshot
 RemainAfterExit=yes
 ExecStart=/usr/local/libexec/my-startup-script

[Install]
 WantedBy=multi-user.target
{% endhighlight %}

### Enable my-startup service

{% highlight bash %}
sudo systemctl enable my-startup
{% endhighlight %}

This command will start the my-startup automatically at reboot. But for now we have to run these commands to ensure we can start the my-startup service and check its status.

{% highlight bash %}
sudo systemctl start my-startup
sudo systemctl status my-startup
{% endhighlight %}

### Credits

Thanks to [Linuxbabe](https://www.linuxbabe.com/linux-server/how-to-enable-etcrc-local-with-systemd) and 
[AskUbuntu StackExchange](https://askubuntu.com/questions/886620/how-can-i-execute-command-on-startup-rc-local-alternative-on-ubuntu-16-10) and 
[Unix StackExchange](https://unix.stackexchange.com/questions/471824/what-is-the-correct-substitute-for-rc-local-in-systemd-instead-of-re-creating-rc) for the helpful instructions.