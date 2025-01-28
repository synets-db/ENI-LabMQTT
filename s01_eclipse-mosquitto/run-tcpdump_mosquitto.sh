#!/bin/bash

# Lancer tcpdump en arrière-plan pour capturer 100 trames
tcpdump -i eth0 -c 200 -w /captures/capture.pcap &

# Lancer Mosquitto en premier plan
/usr/sbin/mosquitto -c /mosquitto/config/mosquitto.conf