import 'package:flutter/cupertino.dart';

abstract class Language {
  String get appName;
  String get randomNumberOptionName;
  String get specificNumberOptionName;
  String get settings;
  String get thai;
  String get congratulation;
  String get doYouWantToPlayAgain;
  String get no;
  String get okay;
  String get letsFun;
  String get guess;
  String get pleaseEnterTheNumber;
  String get key;
  String get pleaseProvideAValue;
  String get pleaseEnterAnInteger;
  String pleaseEnterXDigit(int digit);
  String get pleaseEnterNoDuplicateDigit;
  String get logOut;
  String get history;
  String get noHistory;
  String get howToPlay;
  RichText get howToPlayDesc;
}
