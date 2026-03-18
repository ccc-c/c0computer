#include "kernel/types.h"
#include "user/user.h"
#include "kernel/net/socket.h"

char recvbuf[4096];
char request[1024];

int
main(int argc, char *argv[])
{
    int sock;
    struct sockaddr_in server_addr;
    char *host, *path;
    char *url;
    int port = 80;
    int ret;
    uint32_t server_ip;
    
    if (argc < 2) {
        printf("Usage: curl <URL>\n");
        printf("Example: curl http://example.com\n");
        printf("        curl http://10.0.2.2/\n");
        exit(1);
    }
    
    url = argv[1];
    if (strncmp(url, "http://", 7) == 0) {
        url += 7;
    }
    
    host = url;
    path = strchr(host, '/');
    if (path) {
        *path = '\0';
        path++;
    } else {
        path = "";
    }
    
    char *port_str = strchr(host, ':');
    if (port_str) {
        *port_str = '\0';
        port_str++;
        port = atoi(port_str);
    }
    
    server_ip = 0x0100007F;
    
    printf("Connecting to %s:%d...\n", host, port);
    
    sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (sock < 0) {
        printf("curl: socket failed\n");
        exit(1);
    }
    
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = htonl(server_ip);
    server_addr.sin_port = htons(port);
    
    if (connect(sock, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
        printf("curl: connect failed\n");
        close(sock);
        exit(1);
    }
    
    strcpy(request, "GET /");
    strcat(request, path);
    strcat(request, " HTTP/1.0\r\n");
    strcat(request, "Host: ");
    strcat(request, host);
    strcat(request, "\r\n");
    strcat(request, "User-Agent: xv6-curl/1.0\r\n");
    strcat(request, "Connection: close\r\n");
    strcat(request, "\r\n");
    
    send(sock, request, strlen(request), 0);
    
    while ((ret = recv(sock, recvbuf, sizeof(recvbuf) - 1, 0)) > 0) {
        recvbuf[ret] = '\0';
        printf("%s", recvbuf);
    }
    
    close(sock);
    exit(0);
}
