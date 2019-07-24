---
layout: post
title:  "Welcome to SDN"
date:   2019-07-06 14:58:01 -0400
categories: sdn update
---
To get started with Software Defined Networking here are some resources.

## Basic Networking Primer

Avery Pennarun has written a very entertaining [primer on networking](https://apenwarr.ca/log/20170810) while discussing issues with IPv6. This goes into the details and origins of computer networking and its evolution.

## Historical Overview of SDN

[OpenFlow and P4 Runtime](https://p4.org/p4/clarifying-the-differences-between-p4-and-openflow.html) This article is written by the creator of both OpenFlow and P4, Nick McKeown. 

This provides a very good historical overview of SDN and why they created P4 Language and P4 Runtime.

## OpenFlow Technical Specifications

Read the [Open Networking SDN Technical Specifications for OpenFlow](https://www.opennetworking.org/software-defined-standards/overview/) based switches.

The OpenFlow protocol allows us to modify network flows in physical or virtual switches. The controller for the switch can be either running directly on the hardware switch or remotely, in our case on the DELL desktop computer.

## Open vSwitch Architecture

To gain a very quick understanding of the various components of [Open vSwitch (OVS)](http://www.openvswitch.org/) read [the article on P4 blog introducing P4 and shortcomings of Open vSwitch](https://p4.org/p4/p4-and-open-vswitch.html).

It is ironic to read an article on P4 blog to learn about internals of Open vSwitch. I found their documentation website [Open vSwitch Documentation > Deeper Dive](http://docs.openvswitch.org/en/latest/#deeper-dive) to be very obtuse and hard for a newcomer to this field. 

Open vSwitch is primarily used by [OpenStack](https://www.openstack.org/software/) to build virtual switches for datacenters. OpenStack is the defacto standard for building your own datacenters. [Virtual switches](https://docs.openstack.org/neutron/latest/admin/config-ovs-dpdk.html) and [virtual routers]() are essential components of the [OpenStack networking infrastructure](https://docs.openstack.org/neutron/latest/admin/intro-network-components.html).

However our goal is to create a physical or hardware based switch. The OpenStack website contains tutorials for setting up networks and diagnose and identify problems with OVS.

## DPDK Architecture

When you are building a physical NIC based switch on a desktop or embedded system, you will need to use the [Data Plane Development Kit (DPDK)](https://www.dpdk.org/about/) to accelerate packet processing workloads.

This in turn would require you to build and configure Open vSwitch with the DPDK libraries and modifying the Linux command line options to support IOMMU, VFIO-PCI, and HugePages.

## Faucet SDN Controller

The journey to build a physical SDN switch begins here. Faucet is Python based controller to configure and run Open vSwitch controllers.

The [Faucet on OVS with DPDK](https://docs.faucet.nz/en/latest/vendors/ovs/README_OVS-DPDK.html#faucet-on-ovs-with-dpdk) page is the main entrypoint for our journey. Start there if you want to build your own switch.

## SDN at Google

Watch the following YouTube videos showcasing how Google uses SDN in their infrastructure and some details of internal use cases for various network function virtualizations and the Push To Green deployment.

[Faucet and Enterprise SDN](https://youtu.be/BDje6HGBwso) talk by Stephen Stuart of Google at Open vSwitch at [Open vSwitch 2017 Fall Conference](https://www.youtube.com/channel/UCH8GBLyxWkJDfZG32kr3Y4g).

## P4 Language Consortium

Watch [P4 Workshop 2017 Playlist](https://www.youtube.com/playlist?list=PLf7HGRMAlJByvc8Zd70LxMJfqdwCpF3LM) to get an idea about how SDN is evolving.
