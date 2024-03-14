#DPDK OVS 設定
ovs-vsctl set Open_vSwitch . other_config:dpdk-extra="-a 0000:00:00.0"
ovs-vsctl --no-wait set Open_vSwitch . other_config:dpdk-init=true
ovs-vsctl --no-wait set Open_vSwitch . other_config:doca-init=true
ovs-vsctl set Open_vSwitch . other_config:hw-offload=true

#設定 Bridge
sudo ovs-vsctl add-br br0-ovs -- set Bridge br0-ovs datapath_type=netdev -- br-set-external-id br0-ovs bridge-id br0-ovs -- set bridge br0-ovs fail-mode=standalone

#設定 port
sudo ovs-vsctl add-port br0-ovs p1 -- set Interface p1 type=dpdk options:dpdk-devargs=0000:03:00.1,dv_flow_en=1,dv_esw_en=1,dv_xmeta_en=1
sudo ovs-vsctl add-port br0-ovs pf1vf1 -- set Interface pf1vf1 type=dpdk options:dpdk-devargs=0000:03:00.1,representor=vf1,dv_flow_en=1,dv_esw_en=1,dv_xmeta_en=1
sudo ovs-vsctl add-port br0-ovs pf1vf0 -- set Interface pf1vf0 type=dpdk options:dpdk-devargs=0000:03:00.1,representor=vf0,dv_flow_en=1,dv_esw_en=1,dv_xmeta_en=1

#DOCA OVS 設定
ovs-vsctl --no-wait set Open_vSwitch . other_config:doca-init=true

#port 設定
ovs-vsctl add-port br0-ovs pf1vf0 -- set Interface pf1vf0 type=dpdk options:dpdk-devargs=0000:03:00.1,representor=vf0,dv_flow_en=2,dv_esw_en=1,dv_xmeta_en=4
ovs-vsctl add-port br0-ovs pf1vf1 -- set Interface pf1vf1 type=dpdk options:dpdk-devargs=0000:03:00.1,representor=vf1,dv_flow_en=2,dv_esw_en=1,dv_xmeta_en=4
