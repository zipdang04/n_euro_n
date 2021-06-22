import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  List<Widget> _items = [];
  @override
  Widget build(BuildContext context) {
    _items = [
      WelcomeBox(),
      ProgressBox(),
    ];
    return Container(
      child: ListView.separated(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int _index) {
          return _items.elementAt(_index);
        },
        separatorBuilder: (BuildContext context, int _index) => SizedBox(height: 16,),
      ),
    );
  }
}

class WelcomeBox extends StatelessWidget {
  String _username = '';
  WelcomeBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _username = 'malego';
    return Container(
      padding: EdgeInsets.all(4),
      child: SizedBox(
        height: 96,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Welcome back,', style: Theme.of(context).textTheme.headline4,),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(_username, style: Theme.of(context).textTheme.headline4,),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.red,
              height: 96,
              width: 96,
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressBox extends StatelessWidget {
  double _progressValue = 0;
  int _tasksRemaining = 0;
  ProgressBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _progressValue = 0.75;
    _tasksRemaining = 2;
    return Card(
      child: Container(
        padding: EdgeInsets.all(24),
        child: Row(
          children: [
            SizedBox(
              height: 160,
              width: 160,
              child: Stack(
                children: [
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: CircularProgressIndicator(
                      value: _progressValue,
                      strokeWidth: 24,
                      backgroundColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Center(
                    child: Text((_progressValue * 100).toInt().toString() + '%', style: Theme.of(context).textTheme.headline3),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 160,
              width: 16,
            ),
            SizedBox(
              height: 160,
              width: 128,
              child: Column(
                children: [
                  SizedBox(height: 19,),
                  Text('Complete', style: Theme.of(context).textTheme.headline5,),
                  Text(_tasksRemaining.toString(), style: Theme.of(context).textTheme.headline3,),
                  Text('more tasks', style: Theme.of(context).textTheme.headline5,),
                  SizedBox(height: 18,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenRecommended {
  List<Widget> getRecommendedTasks2InARow() {
    List<Widget> _recommendation = [];
    //
    return _recommendation;
  }
}