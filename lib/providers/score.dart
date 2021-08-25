import 'dart:convert';

import 'package:flutter/widgets.dart';
import '../models/score_item.dart';
import '../models/http_exception.dart';
import '../handler/game_handler.dart';
import 'package:http/http.dart' as http;

class Score with ChangeNotifier {
  final String _authToken;
  final String _userId;

  Score(this._authToken, this._userId);

  Future<void> save(time) async {
    final url = Uri.parse(GameHandler.SAVE_SCORED_URL
        .replaceAll(GameHandler.USER_ID_KEYWORD, _userId)
        .replaceAll(GameHandler.AUTH_KEYWORD, _authToken));
    // print("url > " +
    //     GameHandler.SAVE_SCORED_URL
    //         .replaceAll(GameHandler.USER_ID_KEYWORD, _userId)
    //         .replaceAll(GameHandler.AUTH_KEYWORD, _authToken));
    try {
      final http.Response response = await http.post(
        url,
        body: json.encode({
          'date': DateTime.now().toIso8601String(),
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

  Future<List<ScoreItem>> getScoredByUserId() async {
    //print('getScoredByUserId > ');
    List<ScoreItem> scoreList = [];
    final url = Uri.parse(GameHandler.GET_SCORED_URL
        .replaceAll(GameHandler.USER_ID_KEYWORD, _userId)
        .replaceAll(GameHandler.AUTH_KEYWORD, _authToken));
    // print("url > " +
    //     GameHandler.GET_SCORED_URL
    //         .replaceAll(GameHandler.USER_ID_KEYWORD, _userId)
    //         .replaceAll(GameHandler.AUTH_KEYWORD, _authToken));
    try {
      final http.Response response = await http.get(url);

      final body = json.decode(response.body);

      //print('body > ' + body.toString());
      if (body['error'] != null) {
        //print("==> " + body['error']);
        throw HttpException(body['error']);
      }

      body.forEach((key, value) {
        //print("==> " + value['time_usage']);
        ScoreItem st = ScoreItem(_userId, double.parse(value['time_usage']),
            DateTime.parse(value['date']));
        scoreList.add(st);
      });
    } on Exception catch (e) {
      //print('throw > ' + e.toString());
      throw e;
    } finally {
      //print('finally');
    }

    return scoreList;
  }
}
