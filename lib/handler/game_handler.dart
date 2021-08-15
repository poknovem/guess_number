import 'dart:math';

import 'package:flutter/material.dart';

class GameHandler {
  /// number length
  static final int LENGTH = 4;

  /// random option
  static final String RANDOM_KEY_ID = '1';

  /// specific option
  static final String SPECIFIC_KEY_ID = '2';

  /// firebase database url
  static final String FIREBASE_REALTIME_DATABASE_URL =
      "https://guessnumber-90e65-default-rtdb.asia-southeast1.firebasedatabase.app/";

  /// scored http verb
  static final String SCORED_HTTP_VERB = "scored.json";

  /// scored url
  static final String SCORED_URL =
      FIREBASE_REALTIME_DATABASE_URL + SCORED_HTTP_VERB;

  /// firebase authentication url
  static final String FIREBASE_AUTHENTICATION_API_URL =
      "https://identitytoolkit.googleapis.com/v1/accounts:";

  /// firebase sign up by email url
  static final String FIREBASE_SIGN_UP_BY_EMAIL_API_URL =
      FIREBASE_AUTHENTICATION_API_URL + "signUp?key=";

  /// firebase web api key
  static final String FIREBASE_WEB_API_KEY =
      "AIzaSyAbtl-Ry9LS7ZYDo5yBZ2ZxwHghrKGrExg";

  ///sign up url
  static final String SIGN_UP_URL =
      FIREBASE_SIGN_UP_BY_EMAIL_API_URL + FIREBASE_WEB_API_KEY;

  /// firebase log in by email url
  static final String FIREBASE_LOG_IN_BY_EMAIL_API_URL =
      FIREBASE_AUTHENTICATION_API_URL + "signInWithPassword?key=";

  /// sign up url
  static final String LOG_IN_URL =
      FIREBASE_LOG_IN_BY_EMAIL_API_URL + FIREBASE_WEB_API_KEY;

  /// error message mapping
  static final Map<String, String> ERROR_MESSAGE_MAPPING = {
    'EMAIL_EXISTS': 'The email address is already in use by another account.',
    'OPERATION_NOT_ALLOWED': 'Password sign-in is disabled for this project.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'We have blocked all requests from this device due to unusual activity. Try again later.',
    'EMAIL_NOT_FOUND':
        'There is no user record corresponding to this identifier. The user may have been deleted.',
    'INVALID_PASSWORD':
        'The password is invalid or the user does not have a password.',
    'USER_DISABLED': 'The user account has been disabled by an administrator.',
  };

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

  void alertException(BuildContext context, String title, String errorMessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(errorMessage),
        elevation: 24.0,
        backgroundColor: Theme.of(context).canvasColor,
        actions: [
          FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
