#include "kernel/types.h"
#include "user/user.h"
#include "kernel/net/socket.h"

char recvbuf[1024];
char sendbuf[1024];

void
process_client(int client_sock)
{
    int ret;
    struct winsize {
        short ws_row;
        short ws_col;
        short ws_xpixel;
        short ws_ypixel;
    };
    
    printf("Client connected\n");
    
    const char *welcome = 
        "xv6 Telnet Server\r\n"
        "Type 'exit' to disconnect\r\n"
        "\r\n";
    send(client_sock, welcome, strlen(welcome), 0);
    
    while ((ret = recv(client_sock, recvbuf, sizeof(recvbuf) - 1, 0)) > 0) {
        recvbuf[ret] = '\0';
        
        if (strncmp(recvbuf, "exit", 4) == 0) {
            const char *bye = "Goodbye!\r\n";
            send(client_sock, bye, strlen(bye), 0);
            break;
        }
        
        if (strncmp(recvbuf, "\x03", 1) == 0) {
            break;
        }
        
        printf("Received: %s", recvbuf);
        
        send(client_sock, recvbuf, ret, 0);
    }
    
    printf("Client disconnected\n");
    close(client_sock);
}

int
main(int argc, char *argv[])
{
    int soc, client_sock;
    struct sockaddr_in server_addr, client_addr;
    int client_addr_len;
    int port = 23;
    
    if (argc > 1) {
        port = atoi(argv[1]);
    }
    
    printf("Telnet Server starting on port %d\n", port);
    
    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (soc < 0) {
        printf("telnetd: socket failed\n");
        exit(1);
    }
    
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(port);
    
    if (bind(soc, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
        printf("telnetd: bind failed\n");
        close(soc);
        exit(1);
    }
    
    if (listen(soc, 5) < 0) {
        printf("telnetd: listen failed\n");
        close(soc);
        exit(1);
    }
    
    printf("Telnet Server listening on port %d\n", port);
    
    while (1) {
        client_addr_len = sizeof(client_addr);
        client_sock = accept(soc, (struct sockaddr *)&client_addr, &client_addr_len);
        
        if (client_sock < 0) {
            printf("telnetd: accept failed\n");
            continue;
        }
        
        process_client(client_sock);
    }
    
    close(soc);
    exit(0);
}
