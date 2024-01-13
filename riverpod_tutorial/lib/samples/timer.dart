void main() {
  countUpToOneMillion();
}

void countUpToOneMillion() {
  int startTime = DateTime.now().millisecondsSinceEpoch;

  for (int i = 1; i <= 1000000; i++) {
    // You can perform any operation here if needed
    // print(i);
  }

  int endTime = DateTime.now().millisecondsSinceEpoch;
  double elapsedSeconds = (endTime - startTime) / 1000.0;

  print("Time taken to count up to one million: $elapsedSeconds seconds");
}
