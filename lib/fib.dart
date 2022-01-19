void main() async {
  print('Hello');
  print('Fib 42 = ');
  final answer = await fib(40);
  print(answer);
}

int fib(int n) {
  if (n <= 2) {
    return 1;
  }

  return fib(n - 1) + fib(n - 2);
}
