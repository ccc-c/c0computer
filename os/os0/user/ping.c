#include "kernel/types.h"
#include "user/user.h"
#include "kernel/net/socket.h"

uint32_t
parse_ip(char *ip)
{
    int a, b, c, d;
    char *p = ip;
    
    a = atoi(p);
    p = strchr(p, '.');
    if (!p) return 0;
    p++;
    
    b = atoi(p);
    p = strchr(p, '.');
    if (!p) return 0;
    p++;
    
    c = atoi(p);
    p = strchr(p, '.');
    if (!p) return 0;
    p++;
    
    d = atoi(p);
    
    return ((a & 0xff) | ((b & 0xff) << 8) | ((c & 0xff) << 16) | ((d & 0xff) << 24));
}

int
main(int argc, char *argv[])
{
    int sock;
    struct sockaddr_in dest, src;
    char sendbuf[64] = "PING";
    char recvbuf[128];
    int ret, addrlen;
    uint32_t start, end;
    uint32_t dst_ip;
    int port = 9999;
    
    if (argc < 2) {
        printf("Usage: ping <IP address>\n");
        printf("Example: ping 10.0.2.2\n");
        exit(1);
    }

    dst_ip = parse_ip(argv[1]);
    if (dst_ip == 0) {
        printf("ping: invalid IP address: %s\n", argv[1]);
        exit(1);
    }

    printf("PING %s: 56 data bytes\n", argv[1]);

    sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
    if (sock < 0) {
        printf("ping: socket failed\n");
        exit(1);
    }

    dest.sin_family = AF_INET;
    dest.sin_addr.s_addr = htonl(dst_ip);
    dest.sin_port = htons(port);

    src.sin_family = AF_INET;
    src.sin_addr.s_addr = INADDR_ANY;
    src.sin_port = htons(port);
    
    if (bind(sock, (struct sockaddr *)&src, sizeof(src)) < 0) {
        printf("ping: bind failed\n");
        close(sock);
        exit(1);
    }

    for (int i = 0; i < 4; i++) {
        start = uptime();

        ret = sendto(sock, sendbuf, sizeof(sendbuf), 0, 
                     (struct sockaddr *)&dest, sizeof(dest));
        if (ret < 0) {
            printf("ping: sendto failed\n");
            close(sock);
            exit(1);
        }

        addrlen = sizeof(src);
        ret = recvfrom(sock, recvbuf, sizeof(recvbuf), 0,
                       (struct sockaddr *)&src, &addrlen);
        end = uptime();

        if (ret > 0) {
            uint32_t ip = ntohl(src.sin_addr.s_addr);
            printf("%d bytes from %d.%d.%d.%d: icmp_seq=%d time=%d ms\n",
                   ret,
                   (ip >> 0) & 0xff,
                   (ip >> 8) & 0xff,
                   (ip >> 16) & 0xff,
                   (ip >> 24) & 0xff,
                   i, end - start);
        } else {
            printf("Request timeout for icmp_seq %d\n", i);
        }

        for (volatile int j = 0; j < 100000; j++);
    }

    close(sock);
    exit(0);
}
