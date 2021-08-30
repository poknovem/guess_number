import 'package:flutter/material.dart';
import '../providers/lang.dart';
import 'package:provider/provider.dart';

class HowToPlayScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/howtoplay";
  const HowToPlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Lang lang = Provider.of<Lang>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.language.howToPlay),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                child: lang.language.howToPlayDesc,
                margin: EdgeInsets.all(20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
