import 'package:flutter/material.dart';
import 'package:guess_number/widget/app_drawer.dart';
import '../handler/game_handler.dart';
import '../widget/game_mode_item.dart';

class GameModeScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/game_mode";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess Number'),
      ),
      body: GridView(
        children: [
          GameModeItem(GameHandler.RANDOM_KEY_ID, 'Random Number', Colors.cyan),
          GameModeItem(
              GameHandler.SPECIFIC_KEY_ID, 'Specify Number', Colors.orange),
        ],
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
