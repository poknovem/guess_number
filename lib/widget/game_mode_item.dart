import 'package:flutter/material.dart';
import '../providers/lang.dart';
import 'package:provider/provider.dart';
import '../handler/game_handler.dart';
import '../screen/play_game_screen.dart';

class GameModeItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final _form = GlobalKey<FormState>();
  GameHandler gameHandler = GameHandler();
  GameModeItem(this.id, this.title, this.color);

  void _onSubmit(String value, BuildContext context) {
    //print(value);
    if (_form.currentState!.validate()) {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(
        PlayGame.ROUTE_NAME,
        arguments: {'id': id, 'fixValue': '${value}'},
      );
    }
  }

  void _enterKeyDialog(BuildContext context, Lang lang) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(lang.language.pleaseEnterTheNumber),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _form,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: lang.language.key),
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) => _onSubmit(value, context),
                    validator: (value) {
                      return gameHandler.validateGuessNumber(value!, lang);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        elevation: 24.0,
        backgroundColor: Theme.of(context).canvasColor,
        actions: [],
      ),
    );
  }

  void _selectItem(BuildContext context, Lang lang) {
    if (id == GameHandler.SPECIFIC_KEY_ID) {
      _enterKeyDialog(context, lang);
    } else {
      Navigator.of(context).pushNamed(
        PlayGame.ROUTE_NAME,
        arguments: {'id': id},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Lang lang = Provider.of<Lang>(context);
    return InkWell(
      onTap: () => _selectItem(context, lang),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
