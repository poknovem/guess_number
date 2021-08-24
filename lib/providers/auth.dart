import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import '../models/http_exception.dart';
import '../handler/game_handler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  static final String USERDATA_PREFS_KEY = "userData";
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId => _userId;

  Future<void> _authenticate(
      String email, String password, String urlStr) async {
    final Uri url = Uri.parse(urlStr);
    try {
      final http.Response response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final body = json.decode(response.body);
      //print(body);
      if (body['error'] != null) {
        //print("==> " + body['error']['message']);
        throw HttpException(body['error']['message']);
      }
      _token = body['idToken'];
      _userId = body['localId'];
      // print('_userId > ' + _userId!);
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String(),
      });
      prefs.setString(USERDATA_PREFS_KEY, userData);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, GameHandler.SIGN_UP_URL);
  }

  Future<void> logIn(String email, String password) async {
    return _authenticate(email, password, GameHandler.LOG_IN_URL);
  }

  Future<void> logOut() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logOut);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(USERDATA_PREFS_KEY)) {
      return false;
    }

    String? extractedUserDataTemp = prefs.getString(USERDATA_PREFS_KEY);
    if (extractedUserDataTemp != null) {
      var extractedUserData = json.decode(extractedUserDataTemp);
      final expiryDate =
          DateTime.parse(extractedUserData['expiryDate'] as String);
      if (expiryDate.isBefore(DateTime.now())) {
        return false;
      }

      _token = extractedUserData['token'] as String;
      _userId = extractedUserData['userId'] as String;
      _expiryDate = expiryDate;
      notifyListeners();
      _autoLogout();
      return true;
    }
    return false;
  }
}
