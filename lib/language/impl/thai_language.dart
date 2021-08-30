import 'package:flutter/widgets.dart';

import '../language.dart';

class ThaiLanguage implements Language {
  @override
  String get appName => "Guess Number";

  @override
  String get randomNumberOptionName => "สุ่มตัวเลข";

  @override
  String get specificNumberOptionName => "ระบุตัวเลข";

  @override
  String get settings => "การตั้งค่า";

  @override
  String get thai => "ไทย";

  @override
  String get congratulation => "ยินดีด้วย!!";

  @override
  String get doYouWantToPlayAgain => "ต้องการเล่นอีกไหม?";

  @override
  String get no => "ไม่ละ";

  @override
  String get okay => "ได้เลย";

  @override
  String get letsFun => "สนุกกัน";

  @override
  String get guess => "เดา";

  @override
  String get pleaseEnterTheNumber => "โปรดใส่ตัวเลข!!";

  @override
  String get key => "กำหนดค่า";

  @override
  String get pleaseProvideAValue => "โปรดระบุค่า.";

  @override
  String get pleaseEnterAnInteger => "โปรดใส่จำนวนเต็ม.";

  @override
  String get pleaseEnterNoDuplicateDigit => "โปรดย่าใส่เลขซ้ำ.";

  @override
  String pleaseEnterXDigit(int digit) => "โปรดใส่ $digit อักขระ.";

  @override
  String get logOut => "ล๊อคเอ๊าท์";

  @override
  String get history => "ประวัติการเล่น";

  @override
  String get noHistory => "ไม่พบประวัติการเล่น!!";

  @override
  String get howToPlay => "วิธีการเล่น";

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
          TextSpan(text: '     เกมเดาตัวเลข'),
          TextSpan(
              text: ' 4 ', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
              text:
                  'ตัวมีทั้ง โหมดสุ่มตัวเลข, โหมดระบุตัวเลข ให้เราเดาเล่น\n\nยกตัวอย่างถ้าเลขที่ถูกต้องคือ '),
          TextSpan(
              text: '1234', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '\n\n     - ครั้งที่ 1 เราเดาว่า'),
          TextSpan(
              text: ' 1278 ',
              style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'ตัวเกมจะบอกใบ้ว่าเป็น '),
          TextSpan(
              text: '2A0B', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '\n\n     - ครั้งที่ 2 เราเดาว่า'),
          TextSpan(
              text: ' 1243 ',
              style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'ตัวเกมจะบอกใบ้ว่าเป็น '),
          TextSpan(
              text: '2A2B', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '\n\n     - ครั้งที่ 3 เราเดาว่า'),
          TextSpan(
              text: ' 1234 ',
              style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'จะชนะด้วย '),
          TextSpan(
              text: '4A0B', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '\n\n** ('),
          TextSpan(
              text: ' A ', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '=เลขถูกตำแหน่งถูก, '),
          TextSpan(
              text: ' B ', style: new TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '=เลขถูกตำแหน่งผิด) **'),
        ],
      ),
    );
  }
}
