import 'package:flutter/material.dart';
import 'package:guess_number/screen/play_game_screen.dart';

class GameModeItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  GameModeItem(this.id, this.title, this.color);

  void _selectItem(BuildContext context) {
    Navigator.of(context).pushNamed(
      PlayGame.ROUTE_NAME,
      arguments: {'id': id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectItem(context),
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
