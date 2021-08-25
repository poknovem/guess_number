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
  //bool isFirst = true;

  /**
   * History information fetching is removed from initState() because it is replaced by "FutureBuilder"
   * so don't need to have initState() for the first History information fetching from server anymore.
   * but still StatefulWidget because HistoryScreen can refresh itself by RefreshIndicator
   */
  // @override
  // void initState() {
  //   Provider.of<Score>(context, listen: false)
  //       .getScoredByUserId()
  //       .then((value) {
  //     setState(() {
  //       scoreHistories = value;
  //       isFirst = false;
  //     });
  //   });

  //   super.initState();
  // }

  Future<void> _refreshHistory(BuildContext context) async {
    //print('_refreshHistory');

    /**It is removed because have another fetching at future in FutureBuilder (2 time fetching) */
    // List<ScoreItem> value =
    //     await Provider.of<Score>(context, listen: false).getScoredByUserId();
    setState(() {
      scoreHistories = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    Language lang = Provider.of<Lang>(context).language;
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.appName),
      ),
      body: FutureBuilder(
        future: Provider.of<Score>(context, listen: false).getScoredByUserId()
          /**Must use .. because want return Future<List<ScoreItem>> otherwise it will return Future<Null>*/
          ..then((value) {
            //print('History information fetching done');
            scoreHistories = value;
          }),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //print('waiting');
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            //print('done');
            if (snapshot.hasData) {
              if (snapshot.error != null) {
                //print('error > ' + snapshot.error.toString());
                return Center(
                  child: Text("Some thing went wrong!!"),
                );
              } else {
                //print('no more error');
                return RefreshIndicator(
                  onRefresh: () => _refreshHistory(context),
                  child: Container(
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
            } else {
              return RefreshIndicator(
                onRefresh: () => _refreshHistory(context),
                child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20.0),
                    children: [
                      Center(
                        child: new Text(lang.noHistory),
                      ),
                    ]),
              );
            }
          }
        },
      ),
    );
  }
}
