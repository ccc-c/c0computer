參考 -- https://github.com/pandax381/xv6-riscv-net


xv6 kernel is booting

2026/03/19 04:51:30
04:51:30.963 [I] net_protocol_register: registered, type=0x0800 (kernel/net/net.c:200)
04:51:30.968 [I] net_protocol_register: registered, type=0x0806 (kernel/net/net.c:200)
04:51:30.970 [I] net_timer_register: registered: interval={1, 0} (kernel/net/net.c:220)
04:51:30.970 [I] ip_protocol_register: registered, type=1 (kernel/net/ip.c:320)
04:51:30.974 [I] ip_protocol_register: registered, type=17 (kernel/net/ip.c:320)
04:51:30.978 [I] ip_protocol_register: registered, type=6 (kernel/net/ip.c:320)
04:51:30.980 [I] net_timer_register: registered: interval={0, 100000} (kernel/net/net.c:220)
04:51:30.981 [I] net_init: initialized (kernel/net/net.c:391)
04:51:30.982 [D] virtio_net_init: device found (kernel/net/platform/xv6-riscv/virtio_net.c:351)
04:51:30.989 [I] net_device_register: registered, dev=net0, type=0x0002 (kernel/net/net.c:61)
04:51:30.994 [D] virtio_net_init: initialized, addr=52:54:00:12:34:56 (kernel/net/platform/xv6-riscv/virtio_net.c:426)
04:51:30.998 [D] net_run: open all devices... (kernel/net/net.c:337)
04:51:31.002 [I] net_device_open: dev=net0, state=up (kernel/net/net.c:79)
04:51:31.005 [D] net_run: running... (kernel/net/net.c:341)
hart 2 starting
hart 1 starting
init: starting sh
$ ls
.              1 1 1024
..             1 1 1024
README         2 2 2292
cat            2 3 41944
echo           2 4 40800
forktest       2 5 23528
grep           2 6 45392
ifconfig       2 7 53576
init           2 8 41248
kill           2 9 40720
ln             2 10 40528
ls             2 11 44056
mkdir          2 12 40784
rm             2 13 40768
sh             2 14 63536
stressfs       2 15 41640
tcpecho        2 16 42752
udpecho        2 17 42488
usertests      2 18 187600
grind          2 19 57216
wc             2 20 42920
zombie         2 21 40128
console        3 22 0
$ ./ifconfig net0 192.0.2.2 netmask 255.255.255.0
04:52:59.067 [I] ip_route_add: route added: network=192.0.2.2, netmask=255.255.255.255, nexthop=0.0.0.0, iface=192.0.2.2 dev=net0 (kernel/net/ip.c:165)
04:52:59.075 [I] ip_iface_register: registered: dev=net0, unicast=192.0.2.2, netmask=255.255.255.255, broadcast=192.0.2.2 (kernel/net/ip.c:262)
$ ifconfig
net0: flags=83<UP|BROADCAST|NEEDARP> mtu 1500
  ether 52:54:0:12:34:56
  inet 192.0.2.2 netmask 255.255.255.0 broadcast 192.0.2.255
$ tcpecho
Starting TCP Echo Server
socket: success, soc=3
04:53:09.485 [D] tcp_bind: success: local=0.0.0.0:7 (kernel/net/tcp.c:1056)
bind: success, self=0.0.0.0:7
waiting for connection...


...

d (num:1), dev=net0, type=0x0800, len=84 (kernel/net/net.c:262)
04:57:02.033 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=84 (kernel/net/net.c:284)
04:57:02.035 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=1, total=84 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 49621
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 1
        sum: 0xf4cf
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:02.043 [D] icmp_input: 192.0.2.1 => 192.0.2.2, len=64 (kernel/net/icmp.c:97)
       type: 8 (Echo)
       code: 0
        sum: 0xa624
         id: 9269
        seq: 2
04:57:02.047 [D] icmp_output: 192.0.2.2 => 192.0.2.1, len=64 (kernel/net/icmp.c:133)
       type: 0 (EchoReply)
       code: 0
        sum: 0xae24
         id: 9269
        seq: 2
04:57:02.053 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=1, len=84 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 129
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 1
        sum: 0x3724
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:02.062 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:02.062 [D] net_device_output: dev=net0, type=0x0800, len=84 (kernel/net/net.c:170)
04:57:02.063 [D] ether_transmit_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:03.028 [D] ether_input_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:03.029 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=84 (kernel/net/net.c:262)
04:57:03.030 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=84 (kernel/net/net.c:284)
04:57:03.035 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=1, total=84 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 50447
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 1
        sum: 0xf195
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:03.045 [D] icmp_input: 192.0.2.1 => 192.0.2.2, len=64 (kernel/net/icmp.c:97)
       type: 8 (Echo)
       code: 0
        sum: 0xbb1e
         id: 9269
        seq: 3
04:57:03.046 [D] icmp_output: 192.0.2.2 => 192.0.2.1, len=64 (kernel/net/icmp.c:133)
       type: 0 (EchoReply)
       code: 0
        sum: 0xc31e
         id: 9269
        seq: 3
04:57:03.050 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=1, len=84 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 130
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 1
        sum: 0x3723
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:03.059 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:03.060 [D] net_device_output: dev=net0, type=0x0800, len=84 (kernel/net/net.c:170)
04:57:03.063 [D] ether_transmit_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:04.029 [D] ether_input_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:04.036 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=84 (kernel/net/net.c:262)
04:57:04.040 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=84 (kernel/net/net.c:284)
04:57:04.044 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=1, total=84 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 50521
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 1
        sum: 0xf14b
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:04.057 [D] icmp_input: 192.0.2.1 => 192.0.2.2, len=64 (kernel/net/icmp.c:97)
       type: 8 (Echo)
       code: 0
        sum: 0x6016
         id: 9269
        seq: 4
04:57:04.060 [D] icmp_output: 192.0.2.2 => 192.0.2.1, len=64 (kernel/net/icmp.c:133)
       type: 0 (EchoReply)
       code: 0
        sum: 0x6816
         id: 9269
        seq: 4
04:57:04.061 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=1, len=84 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 131
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 1
        sum: 0x3722
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:04.073 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:04.075 [D] net_device_output: dev=net0, type=0x0800, len=84 (kernel/net/net.c:170)
04:57:04.077 [D] ether_transmit_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:05.031 [D] ether_input_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:05.034 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=84 (kernel/net/net.c:262)
04:57:05.038 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=84 (kernel/net/net.c:284)
04:57:05.041 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=1, total=84 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 51514
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 1
        sum: 0xed6a
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:05.050 [D] icmp_input: 192.0.2.1 => 192.0.2.2, len=64 (kernel/net/icmp.c:97)
       type: 8 (Echo)
       code: 0
        sum: 0xfa0e
         id: 9269
        seq: 5
04:57:05.053 [D] icmp_output: 192.0.2.2 => 192.0.2.1, len=64 (kernel/net/icmp.c:133)
       type: 0 (EchoReply)
       code: 0
        sum: 0x020f
         id: 9269
        seq: 5
04:57:05.056 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=1, len=84 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 132
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 1
        sum: 0x3721
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:05.065 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:05.067 [D] net_device_output: dev=net0, type=0x0800, len=84 (kernel/net/net.c:170)
04:57:05.068 [D] ether_transmit_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:06.033 [D] ether_input_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:06.036 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=84 (kernel/net/net.c:262)
04:57:06.042 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=84 (kernel/net/net.c:284)
04:57:06.045 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=1, total=84 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 52400
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 1
        sum: 0xe9f4
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:06.056 [D] icmp_input: 192.0.2.1 => 192.0.2.2, len=64 (kernel/net/icmp.c:97)
       type: 8 (Echo)
       code: 0
        sum: 0x9806
         id: 9269
        seq: 6
04:57:06.060 [D] icmp_output: 192.0.2.2 => 192.0.2.1, len=64 (kernel/net/icmp.c:133)
       type: 0 (EchoReply)
       code: 0
        sum: 0xa006
         id: 9269
        seq: 6
04:57:06.066 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=1, len=84 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 133
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 1
        sum: 0x3720
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:06.075 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:06.079 [D] net_device_output: dev=net0, type=0x0800, len=84 (kernel/net/net.c:170)
04:57:06.080 [D] ether_transmit_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:07.034 [D] ether_input_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:07.038 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=84 (kernel/net/net.c:262)
04:57:07.042 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=84 (kernel/net/net.c:284)
04:57:07.045 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=1, total=84 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 52722
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 1
        sum: 0xe8b2
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:07.055 [D] icmp_input: 192.0.2.1 => 192.0.2.2, len=64 (kernel/net/icmp.c:97)
       type: 8 (Echo)
       code: 0
        sum: 0x3000
         id: 9269
        seq: 7
04:57:07.058 [D] icmp_output: 192.0.2.2 => 192.0.2.1, len=64 (kernel/net/icmp.c:133)
       type: 0 (EchoReply)
       code: 0
        sum: 0x3800
         id: 9269
        seq: 7
04:57:07.065 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=1, len=84 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 134
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 1
        sum: 0x371f
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:07.074 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:07.077 [D] net_device_output: dev=net0, type=0x0800, len=84 (kernel/net/net.c:170)
04:57:07.079 [D] ether_transmit_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:08.036 [D] ether_input_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:08.042 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=84 (kernel/net/net.c:262)
04:57:08.046 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=84 (kernel/net/net.c:284)
04:57:08.049 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=1, total=84 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 52906
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 1
        sum: 0xe7fa
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:08.058 [D] icmp_input: 192.0.2.1 => 192.0.2.2, len=64 (kernel/net/icmp.c:97)
       type: 8 (Echo)
       code: 0
        sum: 0x07f9
         id: 9269
        seq: 8
04:57:08.062 [D] icmp_output: 192.0.2.2 => 192.0.2.1, len=64 (kernel/net/icmp.c:133)
       type: 0 (EchoReply)
       code: 0
        sum: 0x0ff9
         id: 9269
        seq: 8
04:57:08.066 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=1, len=84 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 135
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 1
        sum: 0x371e
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:08.077 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:08.082 [D] net_device_output: dev=net0, type=0x0800, len=84 (kernel/net/net.c:170)
04:57:08.084 [D] ether_transmit_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:09.037 [D] ether_input_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:09.045 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=84 (kernel/net/net.c:262)
04:57:09.047 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=84 (kernel/net/net.c:284)
04:57:09.054 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=1, total=84 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 53577
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 1
        sum: 0xe55b
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:09.067 [D] icmp_input: 192.0.2.1 => 192.0.2.2, len=64 (kernel/net/icmp.c:97)
       type: 8 (Echo)
       code: 0
        sum: 0x9ff2
         id: 9269
        seq: 9
04:57:09.071 [D] icmp_output: 192.0.2.2 => 192.0.2.1, len=64 (kernel/net/icmp.c:133)
       type: 0 (EchoReply)
       code: 0
        sum: 0xa7f2
         id: 9269
        seq: 9
04:57:09.082 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=1, len=84 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 136
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 1
        sum: 0x371d
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:09.095 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:09.096 [D] net_device_output: dev=net0, type=0x0800, len=84 (kernel/net/net.c:170)
04:57:09.102 [D] ether_transmit_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:10.039 [D] ether_input_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:10.045 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=84 (kernel/net/net.c:262)
04:57:10.051 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=84 (kernel/net/net.c:284)
04:57:10.052 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=1, total=84 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 54553
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 1
        sum: 0xe18b
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:10.063 [D] icmp_input: 192.0.2.1 => 192.0.2.2, len=64 (kernel/net/icmp.c:97)
       type: 8 (Echo)
       code: 0
        sum: 0x90eb
         id: 9269
        seq: 10
04:57:10.068 [D] icmp_output: 192.0.2.2 => 192.0.2.1, len=64 (kernel/net/icmp.c:133)
       type: 0 (EchoReply)
       code: 0
        sum: 0x98eb
         id: 9269
        seq: 10
04:57:10.072 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=1, len=84 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 137
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 1
        sum: 0x371c
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:10.080 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:10.083 [D] net_device_output: dev=net0, type=0x0800, len=84 (kernel/net/net.c:170)
04:57:10.086 [D] ether_transmit_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:11.041 [D] ether_input_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:11.046 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=84 (kernel/net/net.c:262)
04:57:11.048 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=84 (kernel/net/net.c:284)
04:57:11.052 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=1, total=84 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 55372
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 1
        sum: 0xde58
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:11.061 [D] icmp_input: 192.0.2.1 => 192.0.2.2, len=64 (kernel/net/icmp.c:97)
       type: 8 (Echo)
       code: 0
        sum: 0x5fe2
         id: 9269
        seq: 11
04:57:11.065 [D] icmp_output: 192.0.2.2 => 192.0.2.1, len=64 (kernel/net/icmp.c:133)
       type: 0 (EchoReply)
       code: 0
        sum: 0x67e2
         id: 9269
        seq: 11
04:57:11.069 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=1, len=84 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 138
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 1
        sum: 0x371b
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:11.079 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:11.080 [D] net_device_output: dev=net0, type=0x0800, len=84 (kernel/net/net.c:170)
04:57:11.082 [D] ether_transmit_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:12.043 [D] ether_input_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:12.044 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=84 (kernel/net/net.c:262)
04:57:12.044 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=84 (kernel/net/net.c:284)
04:57:12.052 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=1, total=84 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 56308
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 1
        sum: 0xdab0
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:12.064 [D] icmp_input: 192.0.2.1 => 192.0.2.2, len=64 (kernel/net/icmp.c:97)
       type: 8 (Echo)
       code: 0
        sum: 0xf6da
         id: 9269
        seq: 12
04:57:12.066 [D] icmp_output: 192.0.2.2 => 192.0.2.1, len=64 (kernel/net/icmp.c:133)
       type: 0 (EchoReply)
       code: 0
        sum: 0xfeda
         id: 9269
        seq: 12
04:57:12.076 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=1, len=84 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 139
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 1
        sum: 0x371a
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:12.086 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:12.088 [D] net_device_output: dev=net0, type=0x0800, len=84 (kernel/net/net.c:170)
04:57:12.092 [D] ether_transmit_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:13.044 [D] ether_input_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:13.049 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=84 (kernel/net/net.c:262)
04:57:13.052 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=84 (kernel/net/net.c:284)
04:57:13.054 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=1, total=84 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 56660
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 1
        sum: 0xd950
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:13.066 [D] icmp_input: 192.0.2.1 => 192.0.2.2, len=64 (kernel/net/icmp.c:97)
       type: 8 (Echo)
       code: 0
        sum: 0x14d3
         id: 9269
        seq: 13
04:57:13.070 [D] icmp_output: 192.0.2.2 => 192.0.2.1, len=64 (kernel/net/icmp.c:133)
       type: 0 (EchoReply)
       code: 0
        sum: 0x1cd3
         id: 9269
        seq: 13
04:57:13.077 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=1, len=84 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 140
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 1
        sum: 0x3719
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:13.085 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:13.086 [D] net_device_output: dev=net0, type=0x0800, len=84 (kernel/net/net.c:170)
04:57:13.089 [D] ether_transmit_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:14.046 [D] ether_input_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:14.047 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=84 (kernel/net/net.c:262)
04:57:14.052 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=84 (kernel/net/net.c:284)
04:57:14.057 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=1, total=84 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 56768
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 1
        sum: 0xd8e4
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:14.065 [D] icmp_input: 192.0.2.1 => 192.0.2.2, len=64 (kernel/net/icmp.c:97)
       type: 8 (Echo)
       code: 0
        sum: 0x05cc
         id: 9269
        seq: 14
04:57:14.069 [D] icmp_output: 192.0.2.2 => 192.0.2.1, len=64 (kernel/net/icmp.c:133)
       type: 0 (EchoReply)
       code: 0
        sum: 0x0dcc
         id: 9269
        seq: 14
04:57:14.076 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=1, len=84 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 84 (payload: 64)
         id: 141
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 1
        sum: 0x3718
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:14.082 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:14.085 [D] net_device_output: dev=net0, type=0x0800, len=84 (kernel/net/net.c:170)
04:57:14.088 [D] ether_transmit_helper: dev=net0, type=0x0800, len=98 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:32.392 [D] arp_cache_delete: DELETE: pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:101)
04:57:59.358 [D] ether_input_helper: dev=net0, type=0x0800, len=74 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:59.364 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=60 (kernel/net/net.c:262)
04:57:59.365 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=60 (kernel/net/net.c:284)
04:57:59.367 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=6, total=60 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 60 (payload: 40)
         id: 65299
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 6
        sum: 0xb7a4
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:59.374 [D] tcp_input: 192.0.2.1:33028 => 192.0.2.2:7, len=40 (payload=20) (kernel/net/tcp.c:726)
        src: 33028
        dst: 7
        seq: 1356169844
        ack: 0
        off: 0xa0 (40)
        flg: 0x02 (------S-)
        wnd: 64240
        sum: 0x6985
         up: 0
04:57:59.385 [D] tcp_output_segment: 192.0.2.2:7 => 192.0.2.1:33028, len=20 (payload=0) (kernel/net/tcp.c:274)
        src: 7
        dst: 33028
        seq: 1103527590
        ack: 1356169845
        off: 0x50 (20)
        flg: 0x12 (---A--S-)
        wnd: 65535
        sum: 0x170c
         up: 0
04:57:59.391 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=6, len=40 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 40 (payload: 20)
         id: 142
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 6
        sum: 0x373e
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:59.396 [D] arp_resolve: cache not found, pa=192.0.2.1 (kernel/net/arp.c:277)
04:57:59.398 [D] arp_request: dev=net0, len=28 (kernel/net/arp.c:191)
        hrd: 0x0001
        pro: 0x0800
        hln: 6
        pln: 4
         op: 1 (Request)
        sha: 52:54:00:12:34:56
        spa: 192.0.2.2
        tha: 00:00:00:00:00:00
        tpa: 192.0.2.1
04:57:59.408 [D] net_device_output: dev=net0, type=0x0806, len=28 (kernel/net/net.c:170)
04:57:59.409 [D] ether_transmit_helper: dev=net0, type=0x0806, len=60 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: ff:ff:ff:ff:ff:ff
       type: 0x0806
04:57:59.412 [D] ether_input_helper: dev=net0, type=0x0806, len=42 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0806
04:57:59.416 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0806, len=28 (kernel/net/net.c:262)
04:57:59.417 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0806, len=28 (kernel/net/net.c:284)
04:57:59.421 [D] arp_input: dev=net0, len=28 (kernel/net/arp.c:236)
        hrd: 0x0001
        pro: 0x0800
        hln: 6
        pln: 4
         op: 2 (Reply)
        sha: a2:c4:73:62:2a:80
        spa: 192.0.2.1
        tha: 52:54:00:12:34:56
        tpa: 192.0.2.2
04:57:59.428 [D] arp_cache_update: UPDATE: pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:153)
04:57:59.615 [D] tcp_output_segment: 192.0.2.2:7 => 192.0.2.1:33028, len=20 (payload=0) (kernel/net/tcp.c:274)
        src: 7
        dst: 33028
        seq: 1103527590
        ack: 1356169845
        off: 0x50 (20)
        flg: 0x12 (---A--S-)
        wnd: 65535
        sum: 0x170c
         up: 0
04:57:59.621 [D] ip_output_core: dev=net0, dst=192.0.2.1, protocol=6, len=40 (kernel/net/ip.c:433)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 40 (payload: 20)
         id: 143
     offset: 0x0000 [flags=0, offset=0]
        ttl: 255
   protocol: 6
        sum: 0x373d
        src: 192.0.2.2
        dst: 192.0.2.1
04:57:59.628 [D] arp_resolve: resolved, pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:298)
04:57:59.630 [D] net_device_output: dev=net0, type=0x0800, len=40 (kernel/net/net.c:170)
04:57:59.633 [D] ether_transmit_helper: dev=net0, type=0x0800, len=60 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0800
04:57:59.634 [D] ether_input_helper: dev=net0, type=0x0800, len=54 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0800
04:57:59.642 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0800, len=40 (kernel/net/net.c:262)
04:57:59.643 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0800, len=40 (kernel/net/net.c:284)
04:57:59.646 [D] ip_input: dev=net0, iface=192.0.2.2, protocol=6, total=40 (kernel/net/ip.c:374)
        vhl: 0x45 [v: 4, hl: 5 (20)]
        tos: 0x00
      total: 40 (payload: 20)
         id: 65300
     offset: 0x4000 [flags=2, offset=0]
        ttl: 64
   protocol: 6
        sum: 0xb7b7
        src: 192.0.2.1
        dst: 192.0.2.2
04:57:59.652 [D] tcp_input: 192.0.2.1:33028 => 192.0.2.2:7, len=20 (payload=0) (kernel/net/tcp.c:726)
        src: 33028
        dst: 7
        seq: 1356169845
        ack: 1103527591
        off: 0x50 (20)
        flg: 0x10 (---A----)
        wnd: 64240
        sum: 0x1c1c
         up: 0
04:57:59.660 [D] tcp_retransmit_queue_cleanup: remove, seq=1103527590, flags=---A--S-, len=0 (kernel/net/tcp.c:332)
accept: success, peer=192.0.2.1:33028
04:58:04.779 [D] ether_input_helper: dev=net0, type=0x0806, len=42 (kernel/net/ether.c:122)
        src: a2:c4:73:62:2a:80
        dst: 52:54:00:12:34:56
       type: 0x0806
04:58:04.784 [D] net_input_handler: queue pushed (num:1), dev=net0, type=0x0806, len=28 (kernel/net/net.c:262)
04:58:04.786 [D] net_softirq_handler: queue popped (num:0), dev=net0, type=0x0806, len=28 (kernel/net/net.c:284)
04:58:04.787 [D] arp_input: dev=net0, len=28 (kernel/net/arp.c:236)
        hrd: 0x0001
        pro: 0x0800
        hln: 6
        pln: 4
         op: 1 (Request)
        sha: a2:c4:73:62:2a:80
        spa: 192.0.2.1
        tha: 00:00:00:00:00:00
        tpa: 192.0.2.2
04:58:04.795 [D] arp_cache_update: UPDATE: pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:153)
04:58:04.798 [D] arp_reply: dev=net0, len=28 (kernel/net/arp.c:210)
        hrd: 0x0001
        pro: 0x0800
        hln: 6
        pln: 4
         op: 2 (Reply)
        sha: 52:54:00:12:34:56
        spa: 192.0.2.2
        tha: a2:c4:73:62:2a:80
        tpa: 192.0.2.1
04:58:04.804 [D] net_device_output: dev=net0, type=0x0806, len=28 (kernel/net/net.c:170)
04:58:04.805 [D] ether_transmit_helper: dev=net0, type=0x0806, len=60 (kernel/net/ether.c:88)
        src: 52:54:00:12:34:56
        dst: a2:c4:73:62:2a:80
       type: 0x0806
04:58:36.648 [D] arp_cache_delete: DELETE: pa=192.0.2.1, ha=a2:c4:73:62:2a:80 (kernel/net/arp.c:101)