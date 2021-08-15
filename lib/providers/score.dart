import 'dart:convert';

import 'package:flutter/widgets.dart';
import '../models/http_exception.dart';
import '../handler/game_handler.dart';
import 'package:http/http.dart' as http;

class Score with ChangeNotifier {
  final String authToken;

  Score(this.authToken);

  Future<void> save(time) async {
    final url = Uri.parse(GameHandler.SCORED_URL + authToken);
    //print("url > " + GameHandler.SCORED_URL + authToken);
    try {
      final http.Response response = await http.post(
        url,
        body: json.encode({
          'date': DateTime.now().toString(),
          'time_usage': time,
        }),
      );

      final body = json.decode(response.body);
      //print(body);
      if (body['error'] != null) {
        //print("==> " + body['error']);
        throw HttpException(body['error']);
      }
    } on Exception catch (e) {
      throw e;
    }
  }
}
