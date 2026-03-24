x = 10
y = 5
z = 3

if x > y and y > z:
    print("and test pass")

if not (x < y):
    print("not test pass")

if x > y or y > x:
    print("or test pass")

if x > y and y > z and z > 0:
    print("chained and pass")

a = 1
b = 0
if a and not b:
    print("boolean and not pass")