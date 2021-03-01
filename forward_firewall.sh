ipfrontend="10.1.1.5"
ipvideobridge="10.1.1.5"
/usr/sbin/iptables -t nat -F
/usr/sbin/iptables -t nat -A PREROUTING -p tcp --dport 80    -d 172.16.200.104 -j DNAT --to $ipfrontend:80
/usr/sbin/iptables -t nat -A PREROUTING -p tcp --dport 443   -d 172.16.200.104 -j DNAT --to $ipfrontend:443
/usr/sbin/iptables -t nat -A PREROUTING -p tcp --dport 4443  -d 172.16.200.104 -j DNAT --to $ipvideobridge:4443
/usr/sbin/iptables -t nat -A PREROUTING -p udp --dport 10000 -d 172.16.200.104 -j DNAT --to $ipvideobridge:10000
/usr/sbin/iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE
