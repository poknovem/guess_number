import 'package:flutter/material.dart';
import '../providers/lang.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/settings";
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Lang lang = Provider.of<Lang>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.language.settings),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            ListTile(
              title: Text(lang.language.thai),
              trailing: Switch(
                value: lang.isThai,
                onChanged: (value) {
                  lang.changeLanguage();
                },
                activeTrackColor: Colors.yellow,
                activeColor: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
