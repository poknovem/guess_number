import 'dart:math';

class GameHandler {
  static final int LENGTH = 4;
  static final String RANDOM_KEY_ID = '1';
  static final String SPECIFIC_KEY_ID = '2';

  String randomNumber(int length) {
    List<int> numbers = [];
    var rng = new Random();
    while (length > 0) {
      int digit = rng.nextInt(10);
      if (numbers.contains(digit)) continue;
      numbers.add(digit);
      length--;
    }
    return numbers.join();
  }

  String? validateGuessNumber(String value) {
    if (value.isEmpty) {
      return "Please provide a value.";
    }
    if (!isInteger(value)) {
      return "Please enter an integer.";
    }
    if (value.length != GameHandler.LENGTH) {
      return "Please enter ${GameHandler.LENGTH} digit.";
    }
    if (isHasDuplicate(value)) {
      return "Please enter no duplicate digit.";
    }
    return null;
  }

  bool isHasDuplicate(String value) {
    for (int i = 0; i < value.length - 1; i++) {
      String iChar = value.substring(i, i + 1);
      for (int j = i + 1; j < value.length; j++) {
        if (iChar == value.substring(j, j + 1)) {
          return true;
        }
      }
    }
    return false;
  }

  bool isInteger(String value) {
    if (value == null) {
      return false;
    }
    return int.tryParse(value) != null;
  }
}
