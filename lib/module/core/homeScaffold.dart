import 'package:flutter/material.dart';
import 'package:n_euro_n/module/moduleInterface.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({Key? key}) : super(key: key);

  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _selectedTab = 2;
  List<Widget> _tabs = <Widget>[
    Placeholder(color: Colors.indigo,),
    Placeholder(color: Colors.amber,),
    getHomeScreen(),
    Placeholder(color: Colors.deepOrange,),
    Placeholder(color: Colors.deepPurple,)
  ];
  void _onItemTapped(int _index) {
    setState(() {
      _selectedTab = _index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Demo'),),
      body: SafeArea(
        child: Container(
          child: _tabs.elementAt(_selectedTab),
          padding: EdgeInsets.all(16),
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
          BottomNavigationBarItem(icon: Icon(Icons.insert_drive_file_rounded), label: 'Indigo'),
          BottomNavigationBarItem(icon: Icon(Icons.insert_drive_file_rounded), label: 'Amber'),
          BottomNavigationBarItem(icon: Container(/*child: Icon(Icons.insert_drive_file_rounded)*/), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.insert_drive_file_rounded), label: 'Deep Orange'),
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
