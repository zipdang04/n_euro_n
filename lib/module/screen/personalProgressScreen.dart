import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:n_euro_n/module/core/personalProgressHandler.dart';

class PersonalProgressScreen extends StatelessWidget {
  const PersonalProgressScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('gameHistoryBox'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Expanded(
              child: WatchBoxBuilder(
                box: Hive.box('gameHistoryBox'),
                builder: (context, _gameHistoryBox) {
                  final _temp = _gameHistoryBox.get('gameHistory');
                  List<Widget> _items = [
                    Container(
                      height: 200,
                      child: Expanded(
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            //child: Text(_temp.toString()),
                            child: FutureBuilder(
                              future: _getOverallScoreColumn(context),
                              builder: (context, AsyncSnapshot<Widget>snapshot) {
                                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                  return snapshot.data ?? Container();
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                  for (int _i = _temp.length - 1; _i >= 0; _i--) {
                    _items.add(getListTileForPersonalProgressScreen(context, _temp.elementAt(_i)));
                  }
                  _gameHistoryBox.close();
                  return ListView.separated(
                    itemBuilder: (context, _index) => _items.elementAt(_index),
                    separatorBuilder: (context, _index) => SizedBox(height: 4,),
                    itemCount: _items.length,
                  );
                },
              ),
            );
          }
        } else {
          return Container(
            height: 200,
            child: Expanded(
              child: Card(),
            ),
          );
        }
      },
    );
  }
}

Future<Widget> _getOverallScoreColumn(BuildContext context) async {
  List<Widget> _items = [];
  final _value = await getAllOverallScore();
  _value.forEach((key, value) {
    _items.add(Container(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Text(key + ' Game - Overall score: ' + value.toString(),
        style: Theme.of(context).textTheme.headline6,
      ),
    ));
  });
  return Column(
    children: _items,
  );
}