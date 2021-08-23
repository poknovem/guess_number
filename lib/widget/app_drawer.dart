import 'package:flutter/material.dart';
import '../providers/lang.dart';
import '../providers/auth.dart';
import '../screen/settings_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Lang lang = Provider.of<Lang>(context);
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Guess Number'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(lang.language.settings),
            onTap: () {
              Navigator.of(context).pushNamed(SettingsScreen.ROUTE_NAME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(lang.language.logOut),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logOut();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
