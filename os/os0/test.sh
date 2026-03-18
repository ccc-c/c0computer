#!/bin/bash

cd "$(dirname "$0")"

echo "Running all xv6-riscv tests..."

echo ""
echo "=== Network Tests ==="
./test.py test_tcpecho
./test.py test_udpecho
./test.py test_httpd
./test.py test_telnetd
./test.py test_ping
./test.py test_curl
./test.py test_telnet
./test.py test_network_programs

echo ""
echo "=== File System Tests ==="
./test.py test_crash

echo ""
echo "=== User Tests ==="
./test.py test_usertests
