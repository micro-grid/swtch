---
layout: page
title: Bind Ethernet Ports
permalink: /devbind/
---

In order to create DPDK-based OpenvSwitch, we need to bind the physical ports to the kernel module vfio-pci (Virtual Function IO PCI) driver instead of the default e1000e (for Intel NIC) driver.

The Linux kernel selects the default driver for the ports based on manufacturer information reported by the firmware. In our case, we have two manufacturers, Intel and Realtek ethernet cards. Linux binds them to e1000e and r8169 respectively.

We use the `dpdk-devbind.py` script to bind the ports to VFIO-PCI driver. 

Unfortunately the binding to VFIO-PCI does not survive reboot of the system. You need to run this after every reboot.

In Ubuntu versions greater than 18.04, there is another utility, `driverctl` that allows us to persistently bind the ethernet ports to VFIO-PCI. Right now this is not an option for us.

## Get the PCI address for the Intel NIC Card

Run the following command and note the PCI addresses for the Gigabit Ethernet Controller (Copper) 10bc, which is our Intel NIC card. 

The same information can also be mined from `dmesg` log.

```
$DPDK_DIR/usertools/dpdk-devbind.py --status
```

Output of the above command:

```
Network devices using kernel driver
===================================
0000:00:19.0 '82579LM Gigabit Network Connection (Lewisville) 1502' if=eno1 drv=e1000e unused=vfio-pci *Active*
0000:03:00.0 '82571EB/82571GB Gigabit Ethernet Controller (Copper) 10bc' if=enp3s0f0 drv=e1000e unused=vfio-pci 
0000:03:00.1 '82571EB/82571GB Gigabit Ethernet Controller (Copper) 10bc' if=enp3s0f1 drv=e1000e unused=vfio-pci 
0000:04:00.0 '82571EB/82571GB Gigabit Ethernet Controller (Copper) 10bc' if=enp4s0f0 drv=e1000e unused=vfio-pci 
0000:04:00.1 '82571EB/82571GB Gigabit Ethernet Controller (Copper) 10bc' if=enp4s0f1 drv=e1000e unused=vfio-pci 
0000:08:00.0 'RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller 8168' if=enp8s0 drv=r8169 unused=vfio-pci 
0000:09:00.0 'RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller 8168' if=enp9s0 drv=r8169 unused=vfio-pci 
0000:0a:00.0 'RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller 8168' if=enp10s0 drv=r8169 unused=vfio-pci 
0000:0b:00.0 'RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller 8168' if=enp11s0 drv=r8169 unused=vfio-pci 

No 'Crypto' devices detected
============================

No 'Eventdev' devices detected
==============================

No 'Mempool' devices detected
=============================

No 'Compress' devices detected
==============================
```

Here is the complete list of PCI IDs and IF IDs for our Intel NIC Ethernet ports:

```
PCI IDs      NIC IF IDs
0000:03:00.0 if=enp3s0f0
0000:03:00.1 if=enp3s0f1
0000:04:00.0 if=enp4s0f0
0000:04:00.1 if=enp4s0f1
```

You will need these PCI IDs when you bind the ethernet ports (or devices) to use VFIO-PCI driver instead of the e1000e driver used by the Linux kernel.

You will need the `if` (interface) IDs and the PCI IDs when you setup an OVS vSwitch. 

## Configure VFIO-PCI Linux Kernel Module

```
sudo modprobe vfio-pci
```

The above command needs to be run everytime you reboot the machine.

```
@todo: Configure /etc/modules to add vfio-pci kernel module automatically at reboot time.
```

## Verify VFIO-PCI has been loaded

```
sudo lsmod

Module                  Size  Used by
vfio_pci               45056  0
vfio_virqfd            16384  1 vfio_pci
vfio_iommu_type1       24576  0
vfio                   28672  2 vfio_iommu_type1,vfio_pci

Rest of the output truncated ...

```
## Bind the Intel NIC Ports to VFIO-PCI Driver

```
sudo $DPDK_DIR/usertools/dpdk-devbind.py --bind=vfio-pci 0000:03:00.0 0000:03:00.1 0000:04:00.0 0000:04:00.1

```

## Verify the Intel NIC Ports are bound to VFIO-PCI Driver

```
$DPDK_DIR/usertools/dpdk-devbind.py --status

Network devices using DPDK-compatible driver
============================================
0000:03:00.0 '82571EB/82571GB Gigabit Ethernet Controller (Copper) 10bc' drv=vfio-pci unused=e1000e
0000:03:00.1 '82571EB/82571GB Gigabit Ethernet Controller (Copper) 10bc' drv=vfio-pci unused=e1000e
0000:04:00.0 '82571EB/82571GB Gigabit Ethernet Controller (Copper) 10bc' drv=vfio-pci unused=e1000e
0000:04:00.1 '82571EB/82571GB Gigabit Ethernet Controller (Copper) 10bc' drv=vfio-pci unused=e1000e

Rest of the output truncated
```
