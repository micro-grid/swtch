---
layout: page
title: Downloaded Projects
permalink: /dependencies/
---

Here is the list of untarred projects for building the SDN switch. The various `*.tar.gz` files were downloaded from [golang.org](https://golang.org), [DPDK 18.11.x (LTS)](http://core.dpdk.org/download/), and [OpenvSwitch]() websites.

NOTE: Go Programming Language is not required to build and install the SDN Switch. I install it by default on all of my development machines.

{% highlight bash %}
sudo tar -C /usr/local -xf go1.12.6.linux-amd64.tar.gz 
sudo tar -C /usr/src -xf dpdk-18.11.1.tar.xz 

cd $HOME/devel
tar -xvf ~/Downloads/openvswitch-2.11.1.tar.gz 
```

Here is a list of `git clone` projects.

```
cd ~/devel
git clone https://github.com/floodlight/oftest.git
{% endhighlight %}