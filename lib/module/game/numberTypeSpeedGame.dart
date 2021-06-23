import 'dart:async';

import 'package:flutter/material.dart';
import 'package:n_euro_n/module/screen/postgameScreen.dart';

/*
class NumberTypeSpeedGameScreen extends StatefulWidget {
  const NumberTypeSpeedGameScreen({Key? key}) : super(key: key);
  @override
  _NumberTypeSpeedGameScreenState createState() => _NumberTypeSpeedGameScreenState(startingPoint: 0);
}

class _NumberTypeSpeedGameScreenState extends State<NumberTypeSpeedGameScreen> {
  _NumberTypeSpeedGameScreenState({required this.startingPoint});
  int startingPoint;
  String _answerNumber = '1';
  String _answerBoxNumber = '1';
  int _currentLevel = -1;
  int maxLevel = 5;
  int _generateNumberForLevel(int _level) {
    return _level * 101 + 50;
  }
  void _newLevel() {
    _answerBoxNumber = '';
    _currentLevel++;
    _answerNumber = _generateNumberForLevel(_currentLevel).toString();
  }
  Widget _keypadButton(String _buttonID, String _buttonType, String _buttonValue) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_buttonType == 'num') {
              _answerBoxNumber += _buttonValue;
            } else {
              if (_buttonID == 'backspace') {
                _answerBoxNumber = _answerBoxNumber.substring(0, _answerBoxNumber.length - 1);
              } else if (_buttonID == 'delete') {
                _answerBoxNumber = '';
              } else if (_buttonID == 'restart') {
                _currentLevel = 0;
                _newLevel();
              }
            }
            if (_answerNumber == _answerBoxNumber) {
              if (_currentLevel < maxLevel) {
                _newLevel();
              } else {
                _answerNumber = 'Done';
              }
            }
          });
        },
        child: Card(
          color: Theme.of(context).cardColor,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text(_buttonValue,
                style: _buttonType == 'num' ? Theme.of(context).accentTextTheme.headline4 : TextStyle(fontFamily: 'MaterialIcons', fontSize: 46,),
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if (_currentLevel < 0) {
      _currentLevel = startingPoint;
      _newLevel();
    }
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(_answerNumber, style: Theme.of(context).textTheme.headline3,),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  height: 80,
                  child: Expanded(
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text(_answerBoxNumber, style: Theme.of(context).textTheme.headline4,),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  height: 300,
                  child: Expanded(
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Table(
                            children: [
                              TableRow(children: [
                                _keypadButton('1', 'num', '1'),
                                _keypadButton('2', 'num', '2'),
                                _keypadButton('3', 'num', '3'),
                              ]),
                              TableRow(children: [
                                _keypadButton('4', 'num', '4'),
                                _keypadButton('5', 'num', '5'),
                                _keypadButton('6', 'num', '6'),
                              ]),
                              TableRow(children: [
                                _keypadButton('7', 'num', '7'),
                                _keypadButton('8', 'num', '8'),
                                _keypadButton('9', 'num', '9'),
                              ]),
                              TableRow(children: [
                                _keypadButton('restart', 'special', 'delete'),
                                _keypadButton('0', 'num', '0'),
                                _keypadButton('backspace', 'special', 'backspace'),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/

class ReactToKeypad {
  final _controller = StreamController<String>.broadcast();
  Stream<String> get stream => _controller.stream;
  void sendData(String _data) {
    _controller.sink.add(_data);
  }
  void dispose() {
    _controller.close();
  }
}

ReactToKeypad _reactionStream = new ReactToKeypad();
ReactToKeypad _secondaryReactionStream = new ReactToKeypad();
ReactToKeypad _timerUpdateStream = new ReactToKeypad();
ReactToKeypad _scoreUpdateStream = new ReactToKeypad();
var _extBuildContext;

void _closeStreams() {
  _reactionStream.dispose();
  _secondaryReactionStream.dispose();
  _timerUpdateStream.dispose();
  _scoreUpdateStream.dispose();
}

class NumberTypeSpeedGameScreen extends StatelessWidget {
  const NumberTypeSpeedGameScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _extBuildContext = context;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              NumberTypeSpeedGameDisplay(),
              NumberTypeSpeedGameKeypad(context: context),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberTypeSpeedGameKeypad extends StatelessWidget {
  NumberTypeSpeedGameKeypad({Key? key, required BuildContext context}) : super(key: key);
  BuildContext context = _extBuildContext;
  Widget _keypadButton(String _buttonID, String _buttonType, String _buttonValue) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _reactionStream.sendData(_buttonID);
        },
        child: Card(
          color: Theme.of(context).cardColor,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text(_buttonValue,
                style: _buttonType == 'num' ? Theme.of(context).accentTextTheme.headline4 : TextStyle(fontFamily: 'MaterialIcons', fontSize: 46,),
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Expanded(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Table(
                children: [
                  TableRow(children: [
                    _keypadButton('1', 'num', '1'),
                    _keypadButton('2', 'num', '2'),
                    _keypadButton('3', 'num', '3'),
                  ]),
                  TableRow(children: [
                    _keypadButton('4', 'num', '4'),
                    _keypadButton('5', 'num', '5'),
                    _keypadButton('6', 'num', '6'),
                  ]),
                  TableRow(children: [
                    _keypadButton('7', 'num', '7'),
                    _keypadButton('8', 'num', '8'),
                    _keypadButton('9', 'num', '9'),
                  ]),
                  TableRow(children: [
                    _keypadButton('-restart', 'num', 'Start'),
                    _keypadButton('0', 'num', '0'),
                    _keypadButton('-backspace', 'special', 'backspace'),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NumberTypeSpeedGameDisplay extends StatefulWidget {
  const NumberTypeSpeedGameDisplay({Key? key}) : super(key: key);
  @override
  _NumberTypeSpeedGameDisplayState createState() => _NumberTypeSpeedGameDisplayState();
}

class _NumberTypeSpeedGameDisplayState extends State<NumberTypeSpeedGameDisplay> {
  String _answerNumber = 'Press Start';
  int _answerActualNumber = 0;
  String _answerBoxNumber = '';
  int _currentLevel = 0;
  int maxLevel = 3;
  int _score = 0;
  double _counter = 90;
  Timer _timer = Timer.periodic(Duration(days: 1,), (timer) => {});
  bool _finished = false;
  int _generateNumberForLevel(int _level) {
    return _level * 101 + 50;
  }
  void _newLevel() {
    _answerBoxNumber = '';
    _currentLevel++;
    _answerActualNumber = _generateNumberForLevel(_currentLevel);
    _answerNumber = _answerActualNumber.toString();
    _secondaryReactionStream.sendData('update');
  }
  int _getPointPerLevel(int _level, int _number) {
    return _level;
  }
  void _onStreamUpdate(String _value) {
    if (_value[0] == '-') {
      if (_value == '-backspace') {
        if (_answerBoxNumber.isNotEmpty) {
          _answerBoxNumber = _answerBoxNumber.substring(0, _answerBoxNumber.length - 1);
        }
      } else if (_value == '-delete') {
        _answerBoxNumber = '';
      } else if (_value == '-restart') {
        _currentLevel = 0;
        _startGame();
      }
    } else {
      _answerBoxNumber += _value;
    }
    if (_answerNumber == _answerBoxNumber) {
      _score += _getPointPerLevel(_currentLevel, _answerActualNumber);
      if (_currentLevel < maxLevel) {
        _newLevel();
      } else {
        _endGame();
      }
      _secondaryReactionStream.sendData('update');
      _scoreUpdateStream.sendData('update');
    }
  }
  void _startGame() {
    _counter = 91;
    _score = 0;
    _newLevel();
    if (_timer != null) {
      _timer.cancel();
    }
    if (_timer.isActive) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_counter > 0) {
        _counter -= 0.1;
        _counter = (_counter * 10).round() / 10;
        if (_counter >= 90) {
          _reactionStream.sendData('-delete');
        }
        _timerUpdateStream.sendData('update');
      } else if (_counter == 0) {
        _endGame();
      }
    });
  }
  void _endGame() {
    if (_finished) {
      return;
    }
    _finished = true;
    _answerNumber = 'Done';
    _secondaryReactionStream.sendData('update');
    _timer.cancel();
    //_closeStreams();
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostGameScreen(playerScore: _score,)),
    );*/
  }
  @override
  Widget build(BuildContext context) {
    _finished = false;
    //_newLevel();
    //return Container(height: 200, width: 200, color: Colors.red,);
    _timer.cancel();
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Card(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Center(
                      //child: Text(_answerNumber, style: Theme.of(context).textTheme.headline3,),
                      child: StreamBuilder<String>(
                        stream: _secondaryReactionStream.stream,
                        builder: (context, snapshot) {
                          return Text(_answerNumber, style: Theme.of(context).textTheme.headline3,);
                        }
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: StreamBuilder<String>(
                        stream: _scoreUpdateStream.stream,
                        builder: (context, snapshot) {
                          return Text(_score.toString() + 'pts', style: Theme.of(context).textTheme.headline6,);
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: StreamBuilder<String>(
                        stream: _timerUpdateStream.stream,
                        builder: (context, snapshot) {
                          return Text(_counter.toString() + 's', style: Theme.of(context).textTheme.headline6,);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16,),
          Container(
            height: 80,
            child: Expanded(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    //child: Text(_answerBoxNumber, style: Theme.of(context).textTheme.headline4,),
                    child: StreamBuilder<String>(
                      stream: _reactionStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                        } else if (snapshot.connectionState == ConnectionState.done) {
                        } else if (snapshot.hasError) {
                        } else {
                          String _value = snapshot.data.toString();
                          //_onStreamUpdate(_value);
                          if (_counter <= 90) {
                            _onStreamUpdate(_value);
                          }
                        }
                        if (_counter > 90) {
                          _answerBoxNumber = 'Locked';
                        } else if (_answerBoxNumber == 'Locked') {
                          _answerBoxNumber = '';
                        }
                        return Text(_answerBoxNumber, style: Theme.of(context).textTheme.headline4,);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16,),
        ],
      ),
    );
  }
}
