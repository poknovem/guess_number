import 'package:flutter/material.dart';
import '../providers/score.dart';
import '../models/score_item.dart';
import 'package:provider/provider.dart';
import '../language/language.dart';
import '../providers/lang.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  static const String ROUTE_NAME = "/history";
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ScoreItem> scoreHistories = []; //local state
  bool isFirst = true;

  @override
  void initState() {
    Provider.of<Score>(context, listen: false)
        .getScoredByUserId()
        .then((value) {
      setState(() {
        scoreHistories = value;
        isFirst = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Language lang = Provider.of<Lang>(context).language;
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.appName),
      ),
      body: isFirst
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView.builder(
                itemBuilder: (ctx, index) => Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('dd/MM/yy, HH:mm')
                                .format(scoreHistories[index].date),
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "    :    ",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            scoreHistories[index].timeUsage.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                itemCount: scoreHistories.length,
              ),
            ),
    );
  }
}
