import 'package:flutter/material.dart';
import 'package:n_euro_n/module/core/exerciseHandler.dart';
import 'package:n_euro_n/module/core/appTheme.dart';

class preGameScreen extends StatefulWidget {
  preGameScreen({Key? key, required this.exercise}) : super(key: key);
  Exercise exercise;
  @override
  _preGameScreenState createState() => _preGameScreenState(exercise: exercise);
}

class _preGameScreenState extends State<preGameScreen> {
  _preGameScreenState({required this.exercise});
  Exercise exercise;
  List<bool> _selections = List.generate(3, (index) => false);

  void _pushGameScreen() {
    if ((_selections[0] == true) || (_selections[1] == true) || (_selections[2] == true))
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => exercise.getDestination()),
      );
  }

  void _popPreGameScreen() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
        body: new Center(child: new Column(
          children: [
            new SizedBox(height: 60,),
            new Text(exercise.getName(), style: Theme.of(context).textTheme.headline4,),
            new Expanded(child: new Text(exercise.getDescription(), style: Theme.of(context).textTheme.headline6,),),
            new Text(' '),
            _nutPlay(),
            _nutBack(),
            ],
          ),
        ));
        // new Stack(children: [
        //   new ListView(
        //     padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        //     children: [
        //       Text(exercise.getName(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),),
        //       Text(exercise.getDescription(), style: TextStyle(fontSize: 20, color: Colors.white))
        //     ],
        //   ),
        //   new Positioned(
        //       left: 58,
        //       top: 500,
        //       child: _chonDoKho()
        //   ),
        //   new Positioned(
        //       left: 92,
        //       top: 560,
        //       child: _nutPlay()
        //   ),
        //   new Positioned(
        //       top: 650,
        //       left: 157,
        //       child: _nutBack()
        //   ),
        // ],)
  }

  Widget _chonDoKho() {
    return ToggleButtons(
      renderBorder: false,
      color: Colors.white10,
      selectedColor: Colors.white,
      children: [
        new Row(children: <Widget>[new Icon(Icons.add,size: 20.0,color: Colors.green,), new Text("EASY  ",style: TextStyle(fontSize:20, color: Colors.green),)],),
        new Row(children: <Widget>[new Icon(Icons.add,size: 20.0,color: Colors.yellow,), new Text("NORMAL  ",style: TextStyle(fontSize:20, color: Colors.yellow),)],),
        new Row(children: <Widget>[new Icon(Icons.add,size: 20.0,color: Colors.red,), new Text("HARD " ,style: TextStyle(fontSize:20, color: Colors.red))],),
      ],
      isSelected: _selections,
      onPressed: (int _index) {
        setState(() {
          for (int _i = 0; _i < 3; ++_i) _selections[_i] = false;
          _selections[_index] = !_selections[_index];
        });
      },
    );
  }

  Widget _nutPlay() {
    return SizedBox(
        width: 200,
        height: 80,
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
          onPressed: _pushGameScreen,
          child: Text('PLAY!', style: Theme.of(context).textTheme.headline3,),
        )
    );
  }

  Widget _nutBack() {
    return ElevatedButton(
        onPressed: _popPreGameScreen,
        child: Text('BACK', style: Theme.of(context).textTheme.headline6,)
    );
  }
}