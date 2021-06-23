import 'package:flutter/material.dart';
import 'package:n_euro_n/module/core/exerciseHandler.dart';

class PreGameScreen extends StatefulWidget {
  PreGameScreen({Key? key, required this.exercise}) : super(key: key);
  Exercise exercise;
  @override
  _PreGameScreenState createState() => _PreGameScreenState(exercise: exercise);
}

class _PreGameScreenState extends State<PreGameScreen> {
  _PreGameScreenState({required this.exercise});
  Exercise exercise;
  void _navigatorGoBack() {
    Navigator.pop(context);
  }
  void _navigatorLoadGame() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => exercise.getDestination()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(onPressed: _navigatorGoBack, child: Text('Back')),
            Text(exercise.getName()),
            ElevatedButton(onPressed: _navigatorLoadGame, child: Text('Go')),
          ],
        ),
      ),
    );
  }
}
