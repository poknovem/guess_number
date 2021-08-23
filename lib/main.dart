import 'package:flutter/material.dart';
import '../providers/auth.dart';
import '../providers/score.dart';
import '../screen/auth_screen.dart';
import 'package:provider/provider.dart';
import './screen/play_game_screen.dart';
import './screen/game_mode_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Score>(
          create: (BuildContext context) => Score("initial token"),
          update: (BuildContext context, Auth auth, ChangeNotifier? previous) =>
              Score(auth.token!),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.amber,
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                  body1: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  body2: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  title: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
          home: auth.isAuth
              ? GameModeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? CircularProgressIndicator()
                        : AuthScreen();
                  },
                ),
          routes: {
            GameModeScreen.ROUTE_NAME: (ctx) => GameModeScreen(),
            PlayGame.ROUTE_NAME: (ctx) => PlayGame(),
            AuthScreen.ROUTE_NAME: (ctx) => AuthScreen(),
          },
        ),
      ),
    );
  }
}
