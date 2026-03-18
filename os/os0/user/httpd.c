#include "kernel/types.h"
#include "user/user.h"
#include "kernel/net/socket.h"

char *html_response = 
    "HTTP/1.0 200 OK\r\n"
    "Content-Type: text/html\r\n"
    "Connection: close\r\n"
    "\r\n"
    "<html>\n"
    "<head><title>xv6 HTTP Server</title></head>\n"
    "<body>\n"
    "<h1>Welcome to xv6!</h1>\n"
    "<p>This page is served by xv6-riscv with TCP/IP networking.</p>\n"
    "<hr>\n"
    "<p>Server running on QEMU virtio-net</p>\n"
    "</body>\n"
    "</html>\n";

char *not_found_response = 
    "HTTP/1.0 404 Not Found\r\n"
    "Content-Type: text/html\r\n"
    "Connection: close\r\n"
    "\r\n"
    "<html><body><h1>404 Not Found</h1></body></html>\n";

char recvbuf[1024];

int
parse_request(char *buf, int len)
{
    if (len < 4)
        return 0;
    if (strncmp(buf, "GET", 3) == 0)
        return 1;
    return 0;
}

int
main(int argc, char *argv[])
{
    int soc, client_sock;
    struct sockaddr_in server_addr, client_addr;
    int client_addr_len;
    int ret;
    int port = 80;

    if (argc > 1) {
        port = atoi(argv[1]);
    }

    printf("HTTP Server starting on port %d\n", port);

    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (soc < 0) {
        printf("httpd: socket failed\n");
        exit(1);
    }

    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(port);

    if (bind(soc, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
        printf("httpd: bind failed\n");
        close(soc);
        exit(1);
    }

    if (listen(soc, 5) < 0) {
        printf("httpd: listen failed\n");
        close(soc);
        exit(1);
    }

    printf("HTTP Server listening on port %d\n", port);

    while (1) {
        client_addr_len = sizeof(client_addr);
        client_sock = accept(soc, (struct sockaddr *)&client_addr, &client_addr_len);
        
        if (client_sock < 0) {
            printf("httpd: accept failed\n");
            continue;
        }

        ret = recv(client_sock, recvbuf, sizeof(recvbuf) - 1, 0);
        if (ret > 0) {
            recvbuf[ret] = '\0';
            
            if (parse_request(recvbuf, ret)) {
                send(client_sock, html_response, strlen(html_response), 0);
            } else {
                send(client_sock, not_found_response, strlen(not_found_response), 0);
            }
        }

        close(client_sock);
    }

    close(soc);
    exit(0);
}
