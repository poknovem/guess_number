import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../handler/timer_controller.dart';
import '../widget/timer_count_down.dart';
import '../handler/game_handler.dart';
import './game_mode_screen.dart';

class PlayGame extends StatefulWidget {
  static const String ROUTE_NAME = "/play_game";

  @override
  _PlayGameState createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame> {
  final CountdownController _controller =
      new CountdownController(autoStart: true);
  final _form = GlobalKey<FormState>();
  final _guessNumberController = TextEditingController();
  String fixValue = "";
  bool isFirst = true;
  GameHandler gameHandler = GameHandler();

  List<Map<String, String>> _result = [];

  bool isWin = false;

  String calculateTimeToShow(double time) {
    int timeInt = time.truncate();
    int minutes = (timeInt / 60).truncate();
    int seconds = timeInt % 60;

    return "$minutes : $seconds";
  }

  @override
  void dispose() {
    _guessNumberController.dispose();
    super.dispose();
  }

  void _onSubmit(String value) {
    //print(value);
    if (_form.currentState!.validate()) {
      _calculateResult(value);
    }
    _guessNumberController.clear();
  }

  void _calculateResult(String value) {
    //print('fixValue > ' + fixValue);
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
      _congratDialog();
    }
  }

  Future<void> _congratDialog() async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Congratulation!!"),
        content: const Text("Do you want to play again?"),
        elevation: 24.0,
        backgroundColor: Theme.of(context).canvasColor,
        actions: [
          FlatButton(
            child: const Text('No'),
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
            child: const Text('Okay'),
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
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text('Let\'s Fun'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: Countdown(
                controller: _controller,
                seconds: 1,
                build: (_, double time) => Text(
                  calculateTimeToShow(time),
                ),
                interval: Duration(milliseconds: 100),
                onFinished: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Timer is done!'),
                    ),
                  );
                },
                isTimeBackward: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _form,
              child: TextFormField(
                decoration: InputDecoration(labelText: 'guess'),
                //textInputAction: TextInputAction.go,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (value) => _onSubmit(value),
                controller: _guessNumberController,
                validator: (value) {
                  return gameHandler.validateGuessNumber(value!);
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
