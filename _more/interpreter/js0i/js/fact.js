function factorial(n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}

for (let i = 0; i <= 10; i++) {
  console.log(i + "! = " + factorial(i));
}