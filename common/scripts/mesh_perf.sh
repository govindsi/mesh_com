#!/bin/bash


disable_wifi_powersave()
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

exit 0
EOF

}

help()
{
  echo "sudo ./mesh_perf.sh -i wlan0 -p 1 -l value"
}

while getopts ":i:p:l" option; do
  case $option in
    i)
      MESH_IF=${OPTARG};;
    p)
      power_save=${OPTARG};;
    l)
      latency_mode=${OPTARG};;
  esac

done

#Get lshw
apt-get install lshw

wifi_driver_list=$(lshw -C network | awk '$1=="configuration:"{print $3}' | awk -F'driver=' '{print $2}')
echo $wifi_driver_list
echo "disble ps" "$power_save" "$MESH_IF"
for element in $wifi_driver_list;
do
  case $element in
    "ath10k")
      echo "ath10k driver"
      if [ "$power_save" = 1 ];
      then
        disable_wifi_powersave
      fi;;
    "ath11k")
      echo "ath11k driver"
      if [ "$power_save" = 1 ];
      then
        disable_wifi_powersave
      fi;;
    "brcmfmac")
      echo "broadcom full mac driver"
      if [ "$power_save" = 1 ];
      then
        disable_wifi_powersave
      fi;;
    "rt2800pci")
      echo "realteck pci driver"
      if [ "$power_save" = "1" ];
      then
        disable_wifi_powersave
      fi;;
    "rt2800usb")
      echo "realteck usb driver"
      if [ "$power_save" = "1" ];
      then
        disable_wifi_powersave
      fi;;
  esac
done

