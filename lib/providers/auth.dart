import 'dart:convert';

import 'package:flutter/widgets.dart';
import '../models/http_exception.dart';
import '../handler/game_handler.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

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
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );
      notifyListeners();
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
}
