#!/bin/bash
# Test script for RV64I compiler toolchain
# Usage: ./test.sh

set -e

RV0AS="./rv0/rv0as"
RV0VM="./rv0/rv0vm"
DATA_DIR="_data"
CLANG="/opt/homebrew/opt/llvm/bin/clang-21"
RV_CFLAGS="--target=riscv64 -march=rv64g -mabi=lp64d"

echo "=========================================="
echo "Building rv0 tools..."
echo "=========================================="
cd rv0
gcc -o rv0as rv0as.c || { echo "Failed to build rv0as"; exit 1; }
gcc -o rv0vm rv0vm.c || { echo "Failed to build rv0vm"; exit 1; }
gcc -o rv0objdump rv0objdump.c || { echo "Failed to build rv0objdump"; exit 1; }
cd ..
echo "Tools built successfully."
echo ""

# Test definitions: name expected_exit_code entry_point
# entry_point can be 0x0 or special like 0x6c
declare -a TESTS=(
    "test 30 0x0"
    "fact 120 0x6c"
    "test_arith 72 0x0"
    "test_compare 6 0x0"
    "test_bitwise 60 0x0"
    "test_loop 55 0x0"
    "test_pointer 42 0x0"
    "test_while 21 0x0"
    "test_ifelse 3 0x0"
    "test_incdec 24 0x0"
    "test_switch 3 0x0"
    "test_long 100 0x0"
    "test_array2d 7 0x0"
    "test_ptr_arith 3 0x0"
)

PASS=0
FAIL=0

echo "=========================================="
echo "Building and testing all cases..."
echo "=========================================="

for test_info in "${TESTS[@]}"; do
    read -r name expected entry <<< "$test_info"
    
    echo ""
    echo "Testing: $name (expected: $expected, entry: $entry)"
    echo "----------------------------------------"
    
    # Build
    $CLANG $RV_CFLAGS -S "$DATA_DIR/$name.c" -o "$DATA_DIR/$name.s"
    $RV0AS "$DATA_DIR/$name.s" -o "$DATA_DIR/$name.o"
    
    # Run - cross platform grep
    result=$($RV0VM -e "$entry" "$DATA_DIR/$name.o" 2>&1 | grep "a0 =")
    actual=$(echo "$result" | sed 's/.*a0 = \([0-9]*\).*/\1/')
    
    if [ "$actual" = "$expected" ]; then
        echo "PASS: $name (got $actual, expected $expected)"
        ((PASS++))
    else
        echo "FAIL: $name (got $actual, expected $expected)"
        ((FAIL++))
    fi
done

echo ""
echo "=========================================="
echo "Test Summary"
echo "=========================================="
echo "PASSED: $PASS"
echo "FAILED: $FAIL"
echo ""

if [ $FAIL -eq 0 ]; then
    echo "All tests passed!"
    exit 0
else
    echo "Some tests failed."
    exit 1
fi
