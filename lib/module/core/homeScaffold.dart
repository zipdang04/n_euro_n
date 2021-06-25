import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:n_euro_n/module/moduleInterface.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({Key? key}) : super(key: key);

  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _selectedTab = 2, _previousTab = 2;
  List<Widget> _tabs = <Widget>[
    getAllExerciseScreen(),
    getPersonalProgressScreen(),
    getHomeScreen(),
    getTournamentScreen(),
    getSettingScreen(),
  ];
  void _onItemTapped(int _index) {
    if (_selectedTab == _index) {
      return;
    }
    setState(() {
      _previousTab = _selectedTab;
      _selectedTab = _index;
    });
  }
  @override
  Widget build(BuildContext context) {
    _tabs = <Widget>[
      getAllExerciseScreen(),
      getPersonalProgressScreen(),
      getHomeScreen(),
      getTournamentScreen(),
      getSettingScreen(),
    ];
    return Scaffold(
      //appBar: AppBar(title: Text('Demo'),),
      body: SafeArea(
        child: Container(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            child: _tabs.elementAt(_selectedTab),
            switchInCurve: Curves.fastOutSlowIn,
            switchOutCurve: Curves.fastOutSlowIn,
            transitionBuilder: (_child, _animation) {
              Alignment _transitionAlignment = Alignment.center;
              Alignment _fromLeft = Alignment.centerLeft, _fromRight = Alignment.centerRight;
              if (_child != _tabs.elementAt(_selectedTab)) {
                _transitionAlignment = _selectedTab < _previousTab ? _fromRight : _fromLeft;
              } else {
                _transitionAlignment = _selectedTab > _previousTab ? _fromRight : _fromLeft;
              }
              return ScaleTransition(
                child: _child,
                scale: _animation,
                alignment: _transitionAlignment,
              );
            }
            ,
          ),
          //padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(2),
        child: Icon(Icons.dashboard_rounded),
        backgroundColor: _selectedTab == 2 ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded), label: 'All Exercises'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Personal Progress'),
          BottomNavigationBarItem(icon: Container(/*child: Icon(Icons.insert_drive_file_rounded)*/), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'Tournaments'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedTab,
        //selectedItemColor: Colors.red,
        //unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
