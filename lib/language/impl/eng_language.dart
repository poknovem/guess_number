import 'package:flutter/widgets.dart';

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

  @override
  String get howToPlay => "How to play";

  @override
  RichText get howToPlayDesc {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          color: Color.fromRGBO(20, 51, 51, 1),
          fontSize: 20,
          fontFamily: 'Raleway',
        ),
        children: <TextSpan>[
          TextSpan(text: '     Guess'),
          TextSpan(
              text: ' 4 ', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
              text:
                  'number. There are also Random mode, Specific mode.\n\n For Example, If The correct number is '),
          TextSpan(
              text: '1234', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '\n\n     - round 1 guess'),
          TextSpan(
              text: ' 1278 ',
              style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'game will hint '),
          TextSpan(
              text: '2A0B', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '\n\n     - round 2 guess'),
          TextSpan(
              text: ' 1243 ',
              style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'game will hint '),
          TextSpan(
              text: '2A2B', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '\n\n     - round 3 guess'),
          TextSpan(
              text: ' 1234 ',
              style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'You win!! by '),
          TextSpan(
              text: '4A0B', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '\n\n** ('),
          TextSpan(
              text: ' A ', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '=correct number and correct position, '),
          TextSpan(
              text: ' B ', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '=correct number but wrong position) **'),
        ],
      ),
    );
  }
}
