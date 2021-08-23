import 'package:flutter/cupertino.dart';
import '../language/impl/eng_language.dart';
import '../language/impl/thai_language.dart';
import '../language/language.dart';

class Lang with ChangeNotifier {
  bool _isThai = false;
  Language _language = EngLanguage();

  Language get language => _language;

  bool get isThai => _isThai;

  void changeLanguage() {
    if (_isThai) {
      _isThai = false;
      _language = EngLanguage();
    } else {
      _isThai = true;
      _language = ThaiLanguage();
    }
    notifyListeners();
  }
}
