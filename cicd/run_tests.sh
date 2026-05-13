#!/usr/bin/env bash
# Тесты для программы варианта 19
# Подаём на stdin два массива X(10) и Y(10), проверяем содержимое Z

set -u

BINARY="./v19"
if [ ! -x "$BINARY" ]; then
    echo "ERROR: binary $BINARY not found or not executable"
    exit 1
fi

PASS=0
FAIL=0

run_test() {
    local name="$1"
    local input="$2"
    local expected="$3"

    local actual
    actual=$(echo "$input" | "$BINARY" 2>/dev/null | grep "Array Z:" | sed 's/.*Array Z: //' | sed 's/ *$//')
    expected=$(echo "$expected" | sed 's/ *$//')

    if [ "$actual" = "$expected" ]; then
        echo "[PASS] $name"
        PASS=$((PASS+1))
    else
        echo "[FAIL] $name"
        echo "       expected: '$expected'"
        echo "       got     : '$actual'"
        FAIL=$((FAIL+1))
    fi
}

# Test 1: классический случай
run_test "basic case" \
    "1 2 3 4 5 6 7 8 9 100
10 20 30 40 50 -5 -10 0 25 35" \
    "100 -5 -10 0"

# Test 2: пустой Z
run_test "empty Z" \
    "5 5 5 5 5 5 5 5 5 5
5 5 5 5 5 5 5 5 5 5" \
    "-"

# Test 3: только из X
run_test "only from X" \
    "1 2 3 4 5 6 7 8 9 10
1 1 1 1 1 1 1 1 1 1" \
    "2 3 4 5 6 7 8 9 10"

# Test 4: только из Y
run_test "only from Y" \
    "10 10 10 10 10 10 10 10 10 10
5 6 7 8 9 20 20 20 20 20" \
    "5 6 7 8 9"

# Test 5: отрицательные числа
run_test "negative numbers" \
    "-5 -4 -3 -2 -1 0 1 2 3 4
-10 -9 -8 -7 -6 0 1 2 -100 2" \
    "3 4 -10 -9 -8 -7 -6 -100"

echo ""
echo "================================"
echo "Results: $PASS passed, $FAIL failed"
echo "================================"

if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
exit 0
