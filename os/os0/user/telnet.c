#include "kernel/types.h"
#include "user/user.h"
#include "kernel/net/socket.h"

char recvbuf[1024];

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
    struct sockaddr_in server_addr;
    uint32_t server_ip;
    int port = 23;
    int ret;
    
    if (argc < 2) {
        printf("Usage: telnet <IP address> [port]\n");
        printf("Example: telnet 10.0.2.2\n");
        printf("         telnet 10.0.2.2 23\n");
        exit(1);
    }
    
    server_ip = parse_ip(argv[1]);
    if (server_ip == 0) {
        printf("telnet: invalid IP address\n");
        exit(1);
    }
    
    if (argc > 2) {
        port = atoi(argv[2]);
    }
    
    printf("Connecting to %d.%d.%d.%d:%d...\n",
           (server_ip >> 0) & 0xff,
           (server_ip >> 8) & 0xff,
           (server_ip >> 16) & 0xff,
           (server_ip >> 24) & 0xff,
           port);
    
    sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (sock < 0) {
        printf("telnet: socket failed\n");
        exit(1);
    }
    
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = htonl(server_ip);
    server_addr.sin_port = htons(port);
    
    if (connect(sock, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
        printf("telnet: connection failed\n");
        close(sock);
        exit(1);
    }
    
    printf("Connected to %d.%d.%d.%d\n",
           (server_ip >> 0) & 0xff,
           (server_ip >> 8) & 0xff,
           (server_ip >> 16) & 0xff,
           (server_ip >> 24) & 0xff);
    
    printf("Type 'exit' to disconnect\n");
    
    char input[256];
    
    while (1) {
        ret = recv(sock, recvbuf, sizeof(recvbuf) - 1, 0);
        if (ret <= 0) {
            printf("\nConnection closed\n");
            break;
        }
        recvbuf[ret] = '\0';
        printf("%s", recvbuf);
        
        if (gets(input, sizeof(input))) {
            ret = send(sock, input, strlen(input), 0);
            send(sock, "\r\n", 2, 0);
            
            if (strcmp(input, "exit") == 0) {
                printf("Disconnecting...\n");
                break;
            }
        }
    }
    
    close(sock);
    exit(0);
}
