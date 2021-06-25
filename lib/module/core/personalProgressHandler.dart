import 'package:flutter/material.dart';
import 'exerciseInstance/exerciseInstance.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'exerciseHandler.dart';
import 'dart:math';

Future<void> initBoxes() async {
  final _dataBox = await Hive.openBox('dataBox');
  final _gameHistoryBox = await Hive.openBox('gameHistoryBox');
  if (_dataBox.get('gamePlayed', defaultValue: -1) == -1) {
    _dataBox.put('gamePlayed', 0);
  }
  if (_gameHistoryBox.get('gameHistory', defaultValue: -1) == -1) {
    _gameHistoryBox.put('gameHistory', <ExerciseInstance>[]);
  }
  await _dataBox.compact();
  await _gameHistoryBox.compact();
  await Hive.close();
}

Future<void> addGameToHistory(String _name, int _score) async {
  final _dataBox = await Hive.openBox('dataBox');
  final _gameHistoryBox = await Hive.openBox('gameHistoryBox');
  final _gamePlayed = _dataBox.get('gamePlayed');
  final String _gameID = getGameIDFromName(_name);
  if (_dataBox.get(_gameID + 'Highscore', defaultValue: -1) == -1) {
    await _dataBox.put(_gameID + 'Highscore', 0);
  }
  if (_dataBox.get(_gameID + 'OverallScore', defaultValue: -1) == -1) {
    await _dataBox.put(_gameID + 'OverallScore', 0);
  }
  if (_dataBox.get(_gameID + 'RecentScore', defaultValue: -1) == -1) {
    await _dataBox.put(_gameID + 'RecentScore', <int>[]);
  }
  int _highscore = _dataBox.get(_gameID + 'Highscore');
  if (_highscore < _score) {
    _highscore = _score;
    await _dataBox.put(_gameID + 'Highscore', _score);
  }
  await _dataBox.put('gamePlayed', _gamePlayed + 1);
  final DateTime _dateTime = DateTime.now();
  final _currentExerciseInstance = ExerciseInstance(
    id: _gamePlayed + 1,
    exerciseName: _name,
    score: _score,
    dateTime: _dateTime,
  );
  var _gameHistory = _gameHistoryBox.get('gameHistory');
  if (_gameHistory.length >= 20) {
    _gameHistory.removeAt(0);
  }
  _gameHistory.add(_currentExerciseInstance);
  await _gameHistoryBox.put('gameHistory', _gameHistory);
  final List<int> _recentScore = await _dataBox.get(_gameID + 'RecentScore');
  if (_recentScore.length >= 30) {
    _recentScore.removeAt(0);
  }
  _recentScore.add(_score);
  await _dataBox.put(_gameID + 'RecentScore', _recentScore);
  _recentScore.sort();
  int _sum = 0, _counter = 0;
  for (int _i = max<int>(0, _recentScore.length - 20); _i < _recentScore.length; _i++) {
    _sum += _recentScore.elementAt(_i);
    _counter++;
  }
  final int _average = (_sum / _counter).round();
  final int _newOverallScore = _highscore + (_highscore * (1 - pow((1 - _recentScore.length / 30), 2))).round() + _average;
  await _dataBox.put(_gameID + 'OverallScore', _newOverallScore);
  await _dataBox.compact();
  await _gameHistoryBox.compact();
  await Hive.close();
  //print('FINISHED ADDING GAME TO HISTORY');
}

Future<void> clearBoxes() async {
  final _dataBox = await Hive.openBox('dataBox');
  final _gameHistoryBox = await Hive.openBox('gameHistoryBox');
  /*await _dataBox.put('gamePlayed', 0);
  await _gameHistoryBox.put('gameHistory', <ExerciseInstance>[]);
  await _dataBox.delete('gamePlayed');
  await _gameHistoryBox.delete('gameHistory');
  await Hive.close();*/
  await _dataBox.deleteFromDisk();
  await _gameHistoryBox.deleteFromDisk();
  await initBoxes();
}

String _customDateTimeToString(DateTime _dateTime) {
  String _d = _dateTime.day.toString();
  String _m = _dateTime.month.toString();
  String _y = _dateTime.year.toString();
  String _h = _dateTime.hour.toString();
  String _min = _dateTime.minute.toString();
  String _s = _dateTime.minute.toString();
  if (_h.length == 1) {
    _h = '0' + _h;
  }
  if (_min.length == 1) {
    _min = '0' + _min;
  }
  if (_s.length == 1) {
    _s = '0' + _s;
  }

  return '$_d/$_m/$_y - $_h:$_min:$_s';
}

Widget getListTileForPersonalProgressScreen(BuildContext context, ExerciseInstance _instance) {
  return Card(
    child: Container(
      //padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: ListTile(
        minVerticalPadding: 8,
        //
        title: Text(_instance.exerciseName + ' Game: ' + _instance.score.toString() + ' points',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: Padding(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: Text(_customDateTimeToString(_instance.dateTime),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ),
    ),
  );
}

String getGameIDFromName(String _gameName) {
  return _gameName.replaceAll(' ', '');
}

Future<Map<String, int>> getAllOverallScore() async {
  Map<String, int> _output = {};
  List<Exercise> _exerciseList = getExerciseList();
  final _dataBox = await Hive.openBox('dataBox');
  for (int _i = 0; _i < _exerciseList.length; _i++) {
    String _name = _exerciseList.elementAt(_i).getName();
    int _overallScore = _dataBox.get(getGameIDFromName(_name) + 'OverallScore', defaultValue: 0);
    _output[_name] = _overallScore;
  }
  return _output;
}

Future<Map<String, int>> getAllHighscore() async {
  Map<String, int> _output = {};
  List<Exercise> _exerciseList = getExerciseList();
  final _dataBox = await Hive.openBox('dataBox');
  for (int _i = 0; _i < _exerciseList.length; _i++) {
    String _name = _exerciseList.elementAt(_i).getName();
    int _overallScore = _dataBox.get(getGameIDFromName(_name) + 'Highscore', defaultValue: 0);
    _output[_name] = _overallScore;
  }
  return _output;
}