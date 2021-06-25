import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:n_euro_n/module/core/exerciseHandler.dart';
import 'dart:math';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  List<Widget> _items = [];
  @override
  Widget build(BuildContext context) {
    _items = [
      WelcomeBox(),
      ProgressBox(),
    ];
    _items.addAll(HomeScreenDashboard().getDashboardTasks2InARow(context));
    _items.add(Container());
    return Container(
      child: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int _index) {
          return _items.elementAt(_index);
          return Text(_items.toString());
        },
        separatorBuilder: (BuildContext context, int _index) => SizedBox(height: 16,),
        physics: ClampingScrollPhysics(),
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
      child: Container(
        height: 96,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Welcome back', style: Theme.of(context).textTheme.headline4,),
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
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Text('Complete', style: Theme.of(context).textTheme.headline5,),
                    Text(_tasksRemaining.toString(), style: Theme.of(context).textTheme.headline3,),
                    Text('more tasks', style: Theme.of(context).textTheme.headline5,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenDashboard {
  List<Widget> getDashboardTasks2InARow(BuildContext context) {
    List<Exercise> _exerciseList = getExerciseList()..shuffle();
    List<String> _cardText = [
      'New exercises introduced in the 1.0.0 update',
      'Topic: Can you beat the developers?',
      'Recommended exercise for you'
    ];
    List<Widget> _cardNewPage = [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(_cardText.elementAt(0), style: Theme.of(context).textTheme.headline4,),
          SizedBox(height: 16,),
          Text('We are very happy to introduce you our new exercises.',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text('Try them out in the All Exercise Screen - the first tab in the tab bar',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(_cardText.elementAt(1), style: Theme.of(context).textTheme.headline4,),
          SizedBox(height: 16,),
          Text('Try to beat our score at the exercises',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text('malego - Number Type Speed Game - 1200',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(_cardText.elementAt(2), style: Theme.of(context).textTheme.headline4,),
          SizedBox(height: 16,),
          Container(
            height: 200,
            child: ExerciseCard(exerciseData:  _exerciseList.elementAt(0),),
          ),
          SizedBox(height: 16,),
          Container(
            height: 200,
            child: ExerciseCard(exerciseData:  _exerciseList.elementAt(1),),
          ),
        ],
      ),
    ];
    List<Widget> _itemsPending = [];
    for (int _i = 0; _i < _cardText.length; _i++){
      _itemsPending.add(
        Expanded(
          child: Card(
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  height: 80,
                  child: Text(_cardText.elementAt(_i),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Scaffold(
                    appBar: AppBar(),
                    body: SafeArea(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: _cardNewPage.elementAt(_i),
                      ),
                    ),
                  )),
                );
              },
            ),
          ),
        ),
      );
    }
    List<Widget> _items = [];
    for (int _i = 0; _i < _itemsPending.length; _i += 2) {
      _items.add(Row(
        children: [
          _itemsPending.elementAt(_i),
          SizedBox(width: 16,),
          _i + 1 < _itemsPending.length ? _itemsPending.elementAt(_i + 1) : Expanded(child: Container()),
        ],
      ));
    }
    return _items;
  }
}