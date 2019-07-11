---
layout: home
---

A brief outline of how to build a physical 4-port Software Defined Networking (SDN) switch for the Department of Energy's Resilient Micro Grids project.

## Hardware Components

We are building a physical switch on a commodity desktop computer () and a Intel 4-port Network Interface Card (NIC) PCI-Express card.

We also have a Realtek 4-port NIC card, [Zodiac GX OpenFlow Switch](https://northboundnetworks.com/products/zodiac-gx), Raspberry Pi 3 as a SDN Controller, and some other components which we have yet to configure and build.

The software components for SDN switch drive the requirements for the hardware components. 

To learn more about the hardware and software requirments, see the [DPDK Supported Hardware](http://core.dpdk.org/supported/) and the [Open vSwitch with DPDK](http://docs.openvswitch.org/en/stable/intro/install/dpdk/) requirements pages.

## Software Components

Our core software components consist of Linux Ubuntu 18.04 LTS, DPDK 18.11 LTS, and Open vSwitch 2.11 LTS.

We have build DPDK libraries, Open vSwitch Kernel Modules and Daemons with DPDK support. In order to build the software, we have to configure BIOS, configure Linux Kernel Boot Parameters, install various libraries and utilities.

Start with configuring the Linux kernel boot parameters to enable Intel or AMD VT-d and support for HugePages.

### [Configure Linux Boot Parameters](/swtch/cmdline/)

### [Install Apt Packages](/swtch/apt/)

### [Download DPDK & Open vSwitch](/swtch/dependencies/)

### [Build DPDK & Open vSwitch](/swtch/compile)

### [Configure and Run OVS](/swtch/run/)

### [Setup FaucetSDN Controller]()

### [Setup Virtual LANs]()

### [Monitor SDN Switch]()

### [Network Resiliency]()

