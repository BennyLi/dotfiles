#!/bin/sh

# Setup dhcp networking for ethernet port
sudo systemctl enable dhcpd@enp2s0.service
sudo systemctl start  dhcpd@enp2s0.service
