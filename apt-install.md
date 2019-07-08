---
layout: page
title: Ubuntu APT Install Log
permalink: /apt/
---

# APT Install Log

The following software packages were installed on Ubuntu 18.04 Bionic to get DPDK, OpenvSwitch, and
Faucet up and running.

```
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common build-essential pkg-config zip g++ zlib1g-dev unzip python tree htop
sudo apt-get install vim ctags vim-doc vim-scripts 
sudo apt-get install gcc-multilib
sudo apt-get install msr-tools
sudo apt-get install automake autoconf-archive gnu-standards autoconf-doc libtool m4-doc
sudo apt-get install libpcap-dev libmnl-dev libnuma-dev
sudo apt-get install hwloc
sudo apt-get install rdma-core
sudo apt-get install libfabric-dev
sudo apt-get install dapl2-utils libdapl-dev libdapl2
sudo apt-get install ibacm librdmacm-dev rdmacm-utils
sudo apt-get install libelf-dev
sudo apt install i7z linux-tools-common linux-tools-generic
sudo apt-get install openssh-server
sudo apt install python-pip python3-pip
sudo apt install libssl-dev libcap-ng-dev net-tools ethtool nmap socat tshark ngrep inetutils-traceroute graphviz xdot
sudo apt-get install ndiff
sudo apt-get install python3-venv
pip install numpy
pip3 install numpy
sudo apt-get install linux-tools-4.18.0-22-generic
sudo apt-get install git
sudo apt-get install scapy
sudo apt-get install curl gnupg apt-transport-https lsb-release
echo "deb https://packagecloud.io/faucetsdn/faucet/$(lsb_release -si | awk '{print tolower($0)}')/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/faucet.list
curl -L https://packagecloud.io/faucetsdn/faucet/gpgkey | sudo apt-key add -
sudo apt-get install faucet-all-in-one
```
