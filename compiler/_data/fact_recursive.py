def factorial(n):
    if n == 0 or n == 1:
        return 1
    return n * factorial(n - 1)

result = factorial(5)
print(result)

if result == 120:
    print("PASS")
else:
    print("FAIL")
