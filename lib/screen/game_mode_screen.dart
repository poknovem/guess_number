import 'package:flutter/material.dart';
import '../providers/lang.dart';
import '../widget/app_drawer.dart';
import 'package:provider/provider.dart';
import '../handler/game_handler.dart';
import '../widget/game_mode_item.dart';

class GameModeScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/game_mode";

  @override
  Widget build(BuildContext context) {
    Lang lang = Provider.of<Lang>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.language.appName),
      ),
      body: GridView(
        children: [
          GameModeItem(GameHandler.RANDOM_KEY_ID,
              lang.language.randomNumberOptionName, Colors.cyan),
          GameModeItem(GameHandler.SPECIFIC_KEY_ID,
              lang.language.specificNumberOptionName, Colors.orange),
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
