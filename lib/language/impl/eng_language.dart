import '../language.dart';

class EngLanguage implements Language {
  @override
  String get appName => "Guess Number";

  @override
  String get randomNumberOptionName => "Random Number";

  @override
  String get specificNumberOptionName => "Specify Number";

  @override
  String get settings => "Settings";

  @override
  String get thai => "Thai";

  @override
  String get congratulation => "Congratulation!!";

  @override
  String get doYouWantToPlayAgain => "Do you want to play again?";

  @override
  String get no => "No";

  @override
  String get okay => "Okay";

  @override
  String get letsFun => "Let\'s Fun";

  @override
  String get guess => "guess";

  @override
  String get pleaseEnterTheNumber => "Please enter the number!!";

  @override
  String get key => "key";

  @override
  String get pleaseProvideAValue => "Please provide a value.";

  @override
  String get pleaseEnterAnInteger => "Please enter an integer.";

  @override
  String get pleaseEnterNoDuplicateDigit => "Please enter no duplicate digit.";

  @override
  String pleaseEnterXDigit(int digit) => "Please enter $digit digit.";

  @override
  String get logOut => "Log Out";

  @override
  String get history => "History";

  @override
  String get noHistory => "No history!!";
}
