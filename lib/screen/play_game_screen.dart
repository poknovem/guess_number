import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './game_mode_screen.dart';

class PlayGame extends StatefulWidget {
  static const String ROUTE_NAME = "/play_game";

  @override
  _PlayGameState createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame> {
  final _form = GlobalKey<FormState>();
  final _guessNumberController = TextEditingController();

  List<Map<String, String>> _result = [];

  bool isWin = false;

  @override
  void dispose() {
    _guessNumberController.dispose();
    super.dispose();
  }

  void _onSubmit(String value) {
    print(value);
    if (_form.currentState!.validate()) {
      _calculateResult(value);
    }
    _guessNumberController.clear();
  }

  void _calculateResult(String value) {
    String fixValue = '1234';
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
    _result.add({'result': '$a' + 'A' + '$b' + 'B', 'number': value});
    setState(() {
      _result;
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
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  String? _validateGuessNumber(String value) {
    if (value.isEmpty) {
      return "Please provide a value.";
    }
    if (!isInteger(value)) {
      return "Please enter an integer.";
    }
    if (value.length != 4) {
      return "Please enter 4 digit.";
    }
    if (isHasDuplicate(value)) {
      return "Please enter no duplicate digit.";
    }
    return null;
  }

  bool isHasDuplicate(String value) {
    for (int i = 0; i < value.length - 1; i++) {
      for (int j = i + 1; j < value.length; j++) {
        if (value.characters.characterAt(i) ==
            value.characters.characterAt(j)) {
          return true;
        }
      }
    }
    return false;
  }

  bool isInteger(String value) {
    if (value == null) {
      return false;
    }
    return int.tryParse(value) != null;
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    //print(routeArgs['id']);
    return Scaffold(
        appBar: AppBar(
          title: Text('Let\'s Fun'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
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
                    return _validateGuessNumber(value!);
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
        ));
  }
}
