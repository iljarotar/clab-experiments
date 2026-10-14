#!/bin/bash
  
ip l add bridge type bridge vlan_filtering 1
ip l set bridge up

# k3s vrf
ip l add vrf300 type vrf table 30
ip l set vrf300 up

ip l add link bridge name vlan3000 type vlan id 3000
ip l set vlan3000 master vrf300
ip a add 10.100.255.2/32 dev vlan3000
ip l set vlan3000 up

ip l add vtep-3000 type vxlan id 3000 dstport 4789 local 10.100.100.1
ip l set vtep-3000 up
ip l set vtep-3000 master bridge

bridge vlan add dev bridge vid 3000 self
bridge vlan add dev vtep-3000 vid 3000 pvid untagged

# internet vrf
ip l add vrf104030 type vrf table 40
ip l set vrf104030 up
ip l set eth1 master vrf104030

ip l add link bridge name vlan4030 type vlan id 4030
ip l set vlan4030 master vrf104030
ip a add 100.2.1.1/32 dev vlan4030
ip l set vlan4030 up

ip l add vtep-104030 type vxlan id 104030 dstport 4789 local 10.100.100.1
ip l set vtep-104030 up
ip l set vtep-104030 master bridge

bridge vlan add dev bridge vid 4030 self
bridge vlan add dev vtep-104030 vid 4030 pvid untagged

/usr/lib/frr/docker-start&
