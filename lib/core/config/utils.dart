import 'dart:math';

int generateNumericUuid() {
  var random = Random();
  int numericUuid = random.nextInt(9) + 1;
  for (int i = 0; i < 18; i++) {
    numericUuid = numericUuid * 10 + random.nextInt(10);
  }

  return numericUuid;
}