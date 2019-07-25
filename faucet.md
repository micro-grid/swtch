---
layout: page
title: Create Faucet Controller
permalink: /faucet/
---

Follow the [Faucet SDN Controller](https://docs.faucet.nz/en/latest/tutorials/first_time.html) installation instructions.

You should have Prometheus and Grafana configured and running, including importing the three dashboards. 

Modify `/etc/faucet/faucet.yaml` to add our OVS DPDK switch

{% highlight bash %}
vlans:
    grid:
        vid: 100
        description: "grid network"
    guest:
        vid: 200
        description: "guest network"

dps:
    sw1:
        dp_id: 0x0000a0369f083328
        hardware: "Open vSwitch"
        interfaces:
            1:
                name: "h1"
                description: "micro-grid1 container"
                native_vlan: grid
            2:
                name: "h2"
                description: "micro-grid2 container"
                native_vlan: grid
            3:
                name: "h3"
                description: "micro-grid3 container"
                native_vlan: guest
            4:
                name: "h4"
                description: "micro-grid4 container"
                native_vlan: grid
{% endhighlight %}

The `faucet.yaml` is our OpenFlow programming surface. We can create tagged or untagged ports, assign them to vlans, specify access control lists, etc.

Verify your `faucet.yaml` does not have any errors.

{% highlight bash %}
check_faucet_config /etc/faucet/faucet.yaml
{% endhighlight %}

Restart the faucet controller.

{% highlight bash %}
sudo systemctl reload faucet

sudo systemctl status faucet

# Here is the output of the faucet service status

● faucet.service - "Faucet OpenFlow switch controller"
   Loaded: loaded (/lib/systemd/system/faucet.service; enabled; vendor preset: enabled)
   Active: active (running) since Wed 2019-07-24 22:03:09 EDT; 41min ago
     Docs: https://docs.faucet.nz
  Process: 3644 ExecReload=/bin/kill -HUP $MAINPID (code=exited, status=0/SUCCESS)
 Main PID: 1237 (ryu-manager)
    Tasks: 1 (limit: 4915)
   CGroup: /system.slice/faucet.service
           └─1237 /usr/bin/python3 /usr/bin/ryu-manager --config-file=/etc/faucet/ryu.conf --ofp-tcp-listen-port=66

Jul 24 22:42:14 swtch faucet[1237]: 127.0.0.1 - - [24/Jul/2019 22:42:14] "GET /metrics HTTP/1.1" 200 17902 0.002597
Jul 24 22:42:29 swtch faucet[1237]: 127.0.0.1 - - [24/Jul/2019 22:42:29] "GET /metrics HTTP/1.1" 200 17900 0.002627
Jul 24 22:42:44 swtch faucet[1237]: 127.0.0.1 - - [24/Jul/2019 22:42:44] "GET /metrics HTTP/1.1" 200 17901 0.002618
Jul 24 22:42:59 swtch faucet[1237]: 127.0.0.1 - - [24/Jul/2019 22:42:59] "GET /metrics HTTP/1.1" 200 17914 0.002582
Jul 24 22:43:14 swtch faucet[1237]: 127.0.0.1 - - [24/Jul/2019 22:43:14] "GET /metrics HTTP/1.1" 200 17915 0.002630
Jul 24 22:43:29 swtch faucet[1237]: 127.0.0.1 - - [24/Jul/2019 22:43:29] "GET /metrics HTTP/1.1" 200 17914 0.002644
Jul 24 22:43:44 swtch faucet[1237]: 127.0.0.1 - - [24/Jul/2019 22:43:44] "GET /metrics HTTP/1.1" 200 17913 0.002608
Jul 24 22:43:59 swtch faucet[1237]: 127.0.0.1 - - [24/Jul/2019 22:43:59] "GET /metrics HTTP/1.1" 200 17916 0.002623
Jul 24 22:44:14 swtch faucet[1237]: 127.0.0.1 - - [24/Jul/2019 22:44:14] "GET /metrics HTTP/1.1" 200 17913 0.002667
Jul 24 22:44:29 swtch faucet[1237]: 127.0.0.1 - - [24/Jul/2019 22:44:29] "GET /metrics HTTP/1.1" 200 17915 0.002615

# Keep an eye on the faucet.log file

tail /var/log/faucet/faucet.log 

# Here is the output
Jul 24 22:32:59 faucet INFO     Reloading configuration
Jul 24 22:32:59 faucet INFO     configuration /etc/faucet/faucet.yaml changed, analyzing differences
Jul 24 22:32:59 faucet INFO     Add new datapath DPID 176156456792872 (0xa0369f083328)
Jul 24 22:32:59 faucet.valve INFO     DPID 176156456792872 (0xa0369f083328) sw1 table ID 0 table config match_types: (('eth_dst', True), ('eth_type', False), ('in_port', False), ('vlan_vid', False)) name: vlan next_tables: ['eth_src'] output: True set_fields: ('vlan_vid',) size: 32 vlan_port_scale: 1.5
Jul 24 22:32:59 faucet.valve INFO     DPID 176156456792872 (0xa0369f083328) sw1 table ID 1 table config match_types: (('eth_dst', True), ('eth_src', False), ('eth_type', False), ('in_port', False), ('vlan_vid', False)) miss_goto: eth_dst name: eth_src next_tables: ['eth_dst', 'flood'] output: True set_fields: ('vlan_vid', 'eth_dst') size: 32 table_id: 1 vlan_port_scale: 4.1
Jul 24 22:32:59 faucet.valve INFO     DPID 176156456792872 (0xa0369f083328) sw1 table ID 2 table config exact_match: True match_types: (('eth_dst', False), ('vlan_vid', False)) miss_goto: flood name: eth_dst output: True size: 32 table_id: 2 vlan_port_scale: 4.1
Jul 24 22:32:59 faucet.valve INFO     DPID 176156456792872 (0xa0369f083328) sw1 table ID 3 table config match_types: (('eth_dst', True), ('in_port', False), ('vlan_vid', False)) name: flood output: True size: 32 table_id: 3 vlan_port_scale: 2.1
Jul 24 22:33:01 faucet.valve INFO     DPID 176156456792872 (0xa0369f083328) sw1 Cold start configuring DP
Jul 24 22:33:01 faucet.valve INFO     DPID 176156456792872 (0xa0369f083328) sw1 Configuring VLAN grid vid:100 untagged: Port 1,Port 2,Port 4
Jul 24 22:33:01 faucet.valve INFO     DPID 176156456792872 (0xa0369f083328) sw1 Configuring VLAN guest vid:200 untagged: Port 3

{% endhighlight %}


