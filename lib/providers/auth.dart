import 'dart:convert';

import 'package:flutter/widgets.dart';
import '../models/http_exception.dart';
import '../handler/game_handler.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> authenticate(
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
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password) async {
    return authenticate(email, password, GameHandler.SIGN_UP_URL);
  }

  Future<void> logIn(String email, String password) async {
    return authenticate(email, password, GameHandler.LOG_IN_URL);
  }
}
