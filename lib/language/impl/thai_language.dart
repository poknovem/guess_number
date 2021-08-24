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
}
