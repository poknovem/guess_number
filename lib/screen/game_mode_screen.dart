import 'package:flutter/material.dart';
import '../widget/game_mode_item.dart';

class GameModeScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess Number'),
      ),
      body: GridView(
        children: [
          GameModeItem('1', 'Random Number', Colors.cyan),
          GameModeItem('2', 'Specify Number', Colors.orange),
        ],
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
        ),
      ),
    );
  }
}
