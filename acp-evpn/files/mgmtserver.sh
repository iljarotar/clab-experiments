#!/bin/bash
  
ip l add bridge type bridge vlan_filtering 1
ip l set bridge up

# k3s vtep
ip l add vtep-3000 type vxlan id 3000 dstport 4789 local 10.100.100.1
ip l set vtep-3000 up
ip l set vtep-3000 master bridge

bridge vlan add dev bridge vid 3000 self
bridge vlan add dev vtep-3000 vid 3000 pvid untagged

/usr/lib/frr/docker-start&
