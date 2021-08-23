import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../providers/lang.dart';
import '../providers/score.dart';
import '../handler/timer_controller.dart';
import '../widget/timer_stop_watch.dart';
import '../handler/game_handler.dart';
import './game_mode_screen.dart';
import 'package:provider/provider.dart';

class PlayGame extends StatefulWidget {
  static const String ROUTE_NAME = "/play_game";

  @override
  _PlayGameState createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame> {
  final CountdownController _timerController =
      new CountdownController(autoStart: true);
  final _form = GlobalKey<FormState>();
  final _guessNumberController = TextEditingController();
  String fixValue = "";
  bool isFirst = true;
  GameHandler gameHandler = GameHandler();
  bool _isSavingScore = false;

  List<Map<String, String>> _result = [];

  bool isWin = false;

  String calculateTimeToShow(double time) {
    int timeInt = time.truncate();
    int minutes = (timeInt / 60).truncate();
    int seconds = timeInt % 60;
    String result = "";
    if (minutes == 0) {
      result = "$seconds";
    } else {
      result = "$minutes : $seconds";
    }

    return result;
  }

  @override
  void dispose() {
    _guessNumberController.dispose();
    super.dispose();
  }

  void _onSubmit(String value, Lang lang) {
    //print(value);
    if (_form.currentState!.validate()) {
      _calculateResult(value, lang);
    }
    _guessNumberController.clear();
  }

  void _calculateResult(String value, Lang lang) {
    print('fixValue > ' + fixValue);
    int a = 0;
    int b = 0;

    for (int i = 0; i < value.length; i++) {
      for (int j = 0; j < fixValue.length; j++) {
        if (j != i &&
            value.characters.characterAt(i) ==
                fixValue.characters.characterAt(j)) {
          b++;
        } else if (j == i &&
            value.characters.characterAt(i) ==
                fixValue.characters.characterAt(j)) {
          a++;
        }
      }
    }

    setState(() {
      _result.add({'result': '$a' + 'A' + '$b' + 'B', 'number': value});
    });

    if (a == 4) {
      _congratDialog(lang);
    }
  }

  /**
   * For async/await example
   * async => all the code you have in there automatically gets wrapped in to a Future, so don't have to "return" keyword anymore.
   *          And that Future will also be returned automatically (behind the scenes).
   */
  Future<void> _saveScore() async {
    await Provider.of<Score>(context, listen: false).save(
      _timerController.time.toString(),
    );
  }

  Future<void> _congratDialog(Lang lang) async {
    _timerController.pause();

    _timerController.autoStart = false;

    setState(() {
      _isSavingScore = true;
    });

    await _saveScore();

    setState(() {
      _isSavingScore = false;
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(lang.language.congratulation),
        content: Text(lang.language.doYouWantToPlayAgain),
        elevation: 24.0,
        backgroundColor: Theme.of(context).canvasColor,
        actions: [
          FlatButton(
            child: Text(lang.language.no),
            onPressed: () {
              // setState(() {
              //   _result = [];
              //   isWin = false;
              // });

              Navigator.of(context).pushNamedAndRemoveUntil(
                  GameModeScreen.ROUTE_NAME, (route) => false);
            },
          ),
          FlatButton(
            child: Text(lang.language.okay),
            onPressed: () {
              setState(() {
                _result = [];
                isWin = false;
                String tempFixedValue = fixValue;
                while (fixValue == tempFixedValue) {
                  fixValue = gameHandler.randomNumber(GameHandler.LENGTH);
                }
              });
              Navigator.of(context).pop();
              _timerController.restart();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Lang lang = Provider.of<Lang>(context);
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    //print('fixValueTemp > ' + (routeArgs['fixValue'] as String));
    if (isFirst) {
      String id = routeArgs['id'] as String;
      if (id == GameHandler.SPECIFIC_KEY_ID) {
        String fixValueTemp = routeArgs['fixValue'] as String;
        if (fixValueTemp != null || fixValueTemp != '') {
          fixValue = fixValueTemp;
        }
      } else {
        fixValue = gameHandler.randomNumber(GameHandler.LENGTH);
      }
      isFirst = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.language.letsFun),
      ),
      body: _isSavingScore
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 70,
                    margin: EdgeInsets.fromLTRB(0, 15, 15, 0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.cyan.withOpacity(0.4),
                          Colors.cyan,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        StopWatch(
                          controller: _timerController,
                          seconds: 0,
                          build: (_, double time) => Text(
                            calculateTimeToShow(time),
                          ),
                          interval: Duration(milliseconds: 100),
                          // onFinished: () {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text('Timer is done!'),
                          //     ),
                          //   );
                          // },
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _form,
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: lang.language.guess),
                      //textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (value) => _onSubmit(value, lang),
                      controller: _guessNumberController,
                      validator: (value) {
                        return gameHandler.validateGuessNumber(value!, lang);
                      },
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  width: 200,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) => ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text((_result[index]['number'] as String) +
                          ' : ' +
                          (_result[index]['result'] as String)),
                    ),
                    itemCount: _result.length,
                  ),
                ),
              ]),
            ),
    );
  }
}
