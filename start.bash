#!/bin/bash

# Load the VFIO-PCI (Virtual Function IO PCI) Kernel Module
sudo modprobe vfio-pci

# Load the Open vSwitch Kernel Module
sudo modprobe openvswitch

# lsmod and grep for openvswitch and vfio
sudo lsmod | grep -i openvswitch
sudo lsmod | grep -i vfio

# dmesg should report info about openvswitch and vfio
dmesg
# [Mon Day HH:MM] openvswitch: Open vSwitch switching datapath
# [Mon Day HH:MM] VFIO - User Level meta-driver version: 0.3

# Bind the Intel NIC Ethernet Ports to VFIO-PCI driver
sudo $DPDK_DIR/usertools/dpdk-devbind.py --bind=vfio-pci 0000:03:00.0 0000:03:00.1 0000:04:00.0 0000:04:00.1

# Display the ethernet port status
sudo $DPDK_DIR/usertools/dpdk-devbind.py --status

# Check dmesg for enabling vfio-pci for the above ports
dmesg
# [Mon Day HH:MM] vfio-pci 0000:03:00.0: enabling device (0000 -> 0003)
# [  +0.MicroSec] vfio-pci 0000:03:00.1: enabling device (0000 -> 0003)
# [  +0.MicroSec] vfio-pci 0000:04:00.0: enabling device (0000 -> 0003)
# [  +0.MicroSec] vfio-pci 0000:04:00.1: enabling device (0000 -> 0003)

# NOTE: ovsdb-tool, ovsdb-server, ovs-vsctl, ovs-vswitchd can be found in /usr/bin folder
# NOTE: ovs-ctl is a Bash script and not found in the /usr/bin folder, 
# NOTE: it is in /usr/share/openvswitch/scripts folder, 
# NOTE: and this folder is not in sudo PATH variable. 
# NOTE: You have to specify the complete path for ovs-ctl only

# NOTE: This command needs to be run only once to create the conf.db
sudo ovsdb-tool create /etc/openvswitch/conf.db \
    vswitchd/vswitch.ovsschema

# Start the OVSDB-Server and OVS-VSCTL daemon as specified by 
# http://docs.openvswitch.org/en/latest/intro/install/dpdk/

sudo mkdir -p /var/run/openvswitch

sudo ovsdb-server --remote=punix:/var/run/openvswitch/db.sock \
    --remote=db:Open_vSwitch,Open_vSwitch,manager_options \
    --private-key=db:Open_vSwitch,SSL,private_key \
    --certificate=db:Open_vSwitch,SSL,certificate \
    --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert \
    --pidfile --detach --log-file

# ovs-vsctl should be enabled to use DPDK and HugePages
sudo ovs-vsctl --no-wait set Open_vSwitch . other_config:dpdk-init=true other_config:dpdk-hugepage-dir=/dev/hugepages

# Start the ovs-vsctl daemon using the ovs-ctl script, specify not to start the ovsdb-server
sudo /usr/share/openvswitch/scripts/ovs-ctl --no-ovsdb-server start

# Should return true
sudo ovs-vsctl get Open_vSwitch . dpdk_initialized

# Check the output matches the following
sudo ovs-vswitchd --version
# ovs-vswitchd (Open vSwitch) 2.11.1
# DPDK 18.11.1

sudo ovs-vsctl get Open_vSwitch . dpdk_version
# DPDK 18.11.1

# Check the ovs-vswitchd log to ensure ovs started properly
sudo more /var/log/openvswitch/ovs-vswitchd.log

# The /var/run/openvswitch/ directory has the db-sock and other ids
sudo ls -al /var/run/openvswitch/

# 0000:03:00.0 if=enp3s0f0
# 0000:03:00.1 if=enp3s0f1
# 0000:04:00.0 if=enp4s0f0
# 0000:04:00.1 if=enp4s0f1

# Create OVS Virtual Switch with the four Intel NIC Ethernet Ports
sudo ovs-vsctl add-br br0 -- set bridge br0 datapath_type=netdev protocols=OpenFlow13
sudo ovs-vsctl add-port br0 dpdk0 -- set interface dpdk0 type=dpdk options:dpdk-devargs=0000:03:00.0
sudo ovs-vsctl add-port br0 dpdk1 -- set interface dpdk1 type=dpdk options:dpdk-devargs=0000:03:00.1
sudo ovs-vsctl add-port br0 dpdk2 -- set interface dpdk2 type=dpdk options:dpdk-devargs=0000:04:00.0
sudo ovs-vsctl add-port br0 dpdk3 -- set interface dpdk3 type=dpdk options:dpdk-devargs=0000:04:00.1
sudo ovs-vsctl set-fail-mode br0 secure
sudo ovs-vsctl set-controller br0 tcp:127.0.0.1:6653

# Verify bridge name br0, fail_mode secure, protocols OpenFlow13, etc
sudo ovs-vsctl list bridge
# _uuid               : efe0a687-a80c-4660-ba74-3b40cbde7b50
# auto_attach         : []
# controller          : [0ca6ce20-8f52-435a-88b0-205e9165f64e]
# datapath_id         : "0000a0369f083328"
# datapath_type       : netdev
# datapath_version    : "<built-in>"
# external_ids        : {}
# fail_mode           : secure
# flood_vlans         : []
# flow_tables         : {}
# ipfix               : []
# mcast_snooping_enable: false
# mirrors             : []
# name                : "br0"
# netflow             : []
# other_config        : {}
# ports               : [3df7ddde-e467-42a3-9465-25c4f3bdff6d, a106f349-6ba3-4d3e-a0ed-30f47e20e927, c353d7fc-4e69-47af-b2f6-5962548ec390, cf5c2ff1-fc4d-4784-befb-29997adaef88, ea30e361-007a-48bc-81fc-ebda9345d3eb]
# protocols           : ["OpenFlow13"]
# rstp_enable         : false
# rstp_status         : {}
# sflow               : []
# status              : {}
# stp_enable          : false

sudo ovs-ofctl -O OpenFlow13 show br0
# OFPT_FEATURES_REPLY (OF1.3) (xid=0x2): dpid:0000a0369f083328
# n_tables:254, n_buffers:0
# capabilities: FLOW_STATS TABLE_STATS PORT_STATS GROUP_STATS QUEUE_STATS
# OFPST_PORT_DESC reply (OF1.3) (xid=0x3):
#  1(dpdk0): addr:a0:36:9f:08:33:29
#      config:     0
#      state:      LINK_DOWN
#      current:    OTHER
#      speed: 0 Mbps now, 0 Mbps max
#  2(dpdk1): addr:a0:36:9f:08:33:28
#      config:     0
#      state:      LINK_DOWN
#      current:    OTHER
#      speed: 0 Mbps now, 0 Mbps max
#  3(dpdk2): addr:a0:36:9f:08:33:2b
#      config:     0
#      state:      LINK_DOWN
#      current:    OTHER
#      speed: 0 Mbps now, 0 Mbps max
#  4(dpdk3): addr:a0:36:9f:08:33:2a
#      config:     0
#      state:      LINK_DOWN
#      current:    OTHER
#      speed: 0 Mbps now, 0 Mbps max
#  LOCAL(br0): addr:a0:36:9f:08:33:28
#      config:     PORT_DOWN
#      state:      LINK_DOWN
#      current:    10MB-FD COPPER
#      speed: 10 Mbps now, 0 Mbps max
# OFPT_GET_CONFIG_REPLY (OF1.3) (xid=0x9): frags=normal miss_send_len=0

# Faucet needs the datapath_id for br0, make a note of it
sudo ovs-vsctl get bridge br0 datapath_id
# "0000a0369f083328"




# To stop any previous OVS Controller
sudo /usr/share/openvswitch/scripts/ovs-ctl stop
