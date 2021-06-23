#!/bin/bash


apply_radio_config()
{
test -f /etc/network/if-up.d/mesh_if_ps | exit

cat > /etc/network/if-up.d/mesh_if_ps<<EOF
#! /bin/sh

set -e

# exit if not mesh if
if [ "\$IFACE" != $MESH_IF ]; then
        exit 0
fi

if [ "\$MODE" != start ]; then
        exit 0
fi

if [ "\$ADDRFAM" != inet ]; then
        exit 0
fi

/sbin/iw dev $MESH_IF set power_save off
/sbin/iw phy $phy_if set txpower fixed $tx_power
/sbin/iw phy $phy_if set distance $distance
/sbin/iw phy $phy_if set coverage $coverage_class
exit 0
EOF

}

help()
{
  echo "sudo ./mesh_perf.sh -i wlan0 -l value"
}

while getopts ":i:l" option; do
  case $option in
    i)
      MESH_IF=${OPTARG};;
    l)
      latency_mode=${OPTARG};;
  esac

done

CONF_FILE="mesh_perf.conf"
ps_disable=$(awk '/^ps_disable/{print $3}' $CONF_FILE)
tx_power=$(awk '/^tx_power/{print $3}' $CONF_FILE)
distance=$(awk '/^distance/{print $3}' $CONF_FILE)
coverage_class=$(awk '/^coverage_class/{print $3}' $CONF_FILE)

echo "Govind" $ps_disable $tx_power $distance $coverage_class

#Get lshw
apt-get install lshw

wifi_driver_list=$(lshw -C network | awk '$1=="configuration:"{print $3}' | awk -F'driver=' '{print $2}')
echo $wifi_driver_list
echo "ps mode:""$ps_disable" "mesh if:""$MESH_IF"
phy_if=$(iw dev wlp2s0 info | awk '/wiphy/ {printf "phy" $2}')
for element in $wifi_driver_list;
do
  case $element in
    "ath10k")
      echo "ath10k driver"
      if [ -f "$CONF_FILE" ];
      then
        apply_radio_config
      fi;;
    "ath11k")
      echo "ath11k driver"
      if [ -f "$CONF_FILE" ];
      then
        apply_radio_config
      fi;;
    "brcmfmac")
      echo "broadcom full mac driver"
      if [ -f "$CONF_FILE" ];
      then
        apply_radio_config
      fi;;
    "rt2800pci")
      echo "realteck pci driver"
      if [ -f "$CONF_FILE" ];
      then
        apply_radio_config
      fi;;
    "rt2800usb")
      echo "realteck usb driver"
      if [ -f "$CONF_FILE" ];
      then
        apply_radio_config
      fi;;
  esac
done

