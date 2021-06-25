import 'package:flutter/material.dart';

class TournamentScreen extends StatelessWidget {
  TournamentScreen({Key? key}) : super(key: key);
  List<Widget> _items = [];
  @override
  Widget build(BuildContext context) {
    _items = [
      PersonalRankBox(),
      UniversalRankBox(),
      TopRankBox(),
      NearbyRankBox(),
    ];
    return Stack(
      children: [
        ListView.separated(
          padding: EdgeInsets.all(16),
          itemCount: _items.length,
          itemBuilder: (context, _index) => _items.elementAt(_index),
          separatorBuilder: (context, _index) => SizedBox(height: 16,),
        ),
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Theme.of(context).shadowColor,
                    Color(0x00),
                  ],
                )
            ),
          ),
        ),
        IgnorePointer(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 64),
            alignment: Alignment.bottomCenter,
            child: Text('Coming soon', style: Theme.of(context).textTheme.headline3,),
          ),
        ),
      ],
    );
  }
}

class PersonalRankBox extends StatelessWidget {
  String _username = '';
  int _score = 0;
  PersonalRankBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _username = 'Player';
    _score = 132;
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
                    child: Text(_username, style: Theme.of(context).textTheme.headline4,),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Score: $_score', style: Theme.of(context).textTheme.headline4,),
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

class UniversalRankBox extends StatelessWidget {
  double _playersBeatenPercentage = 0;
  int _playerRank = 37;
  UniversalRankBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _playersBeatenPercentage = 0.75;
    return Card(
      child: Container(
        padding: EdgeInsets.fromLTRB(32, 16, 48, 16),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Text("Your rank:", style: Theme.of(context).textTheme.headline5,),
                    Text('#$_playerRank', style: Theme.of(context).textTheme.headline4,),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 160,
              width: 24,
            ),
            SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                children: [
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: CircularProgressIndicator(
                      value: _playersBeatenPercentage,
                      strokeWidth: 16,
                      backgroundColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Center(
                    child: Text((_playersBeatenPercentage * 100).toInt().toString() + '%', style: Theme.of(context).textTheme.headline4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopRankBox extends StatelessWidget {
  List<String> _topPlayersNames = ['Alex', 'Tom', 'Linda'];
  List<int> _topPlayersScores = [240, 225, 204];
  TopRankBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 24,),
                    Container(
                      height: 60,
                      width: 60,
                      color: Colors.red,
                    ),
                    SizedBox(height: 8,),
                    Text(_topPlayersNames[1], style: Theme.of(context).textTheme.headline5,),
                    SizedBox(height: 8,),
                    Text('#2', style: Theme.of(context).textTheme.headline6,),
                    Text(_topPlayersScores[1].toString(), style: Theme.of(context).textTheme.headline6,),
                    SizedBox(height: 24,),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      color: Colors.red,
                    ),
                    SizedBox(height: 8,),
                    Text(_topPlayersNames[0], style: Theme.of(context).textTheme.headline5,),
                    SizedBox(height: 8,),
                    Text('#1', style: Theme.of(context).textTheme.headline6,),
                    Text(_topPlayersScores[0].toString(), style: Theme.of(context).textTheme.headline6,),
                    SizedBox(height: 48,),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 48,),
                    Container(
                      height: 60,
                      width: 60,
                      color: Colors.red,
                    ),
                    SizedBox(height: 8,),
                    Text(_topPlayersNames[2], style: Theme.of(context).textTheme.headline5,),
                    SizedBox(height: 8,),
                    Text('#3', style: Theme.of(context).textTheme.headline6,),
                    Text(_topPlayersScores[2].toString(), style: Theme.of(context).textTheme.headline6,),
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

class NearbyRankBox extends StatelessWidget {
  const NearbyRankBox({Key? key}) : super(key: key);
  Widget _getPlayerAt(BuildContext context, String _name, int _rank, int _score) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        tileColor: Theme.of(context).shadowColor,
        title: Text(_name, style: Theme.of(context).textTheme.subtitle1,),
        subtitle: Container(
          child: Text('Rank: #$_rank | Score: $_score', style: Theme.of(context).textTheme.subtitle2,),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getPlayerAt(context, 'Sophie', 35, 145),
        _getPlayerAt(context, 'Matt', 36, 141),
        _getPlayerAt(context, 'You - Player', 37, 132),
        _getPlayerAt(context, 'Sarah', 38, 122),
        _getPlayerAt(context, 'Andrew', 39, 117),
      ],
    );
  }
}
