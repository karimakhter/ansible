#!/bin/bash

#Accept traffic from loopback interface (localhost).
iptables -A INPUT -i lo -j ACCEPT


{% for port in firewall_allowed_tcp_ports %}
iptables -A INPUT -p tcp -m tcp --dport {{ port }} -j ACCEPT
{% endfor %}


iptables -A INPUT -p icmp -j ACCEPT 

# Allow NTP traffic for time synchronization.
iptables -A OUTPUT -p udp --dport 123 -j ACCEPT
iptables -A INPUT -p udp --sport 123 -j ACCEPT

iptables -A INPUT -s 10.0.2.2 -j ACCEPT
iptables -A INPUT -s 192.168.180.0/24 -j ACCEPT


#Drop all other traffic.
iptables -A INPUT -j DROP