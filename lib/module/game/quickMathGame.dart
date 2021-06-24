import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:n_euro_n/module/screen/postgameScreen.dart';

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

class QuickMathGameScreen extends StatelessWidget {
  const QuickMathGameScreen({Key? key}) : super(key: key);
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
              QuickMathGameDisplay(),
              QuickMathGameKeypad(context: context),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickMathGameKeypad extends StatelessWidget {
  QuickMathGameKeypad({Key? key, required BuildContext context})
      : super(key: key);
  BuildContext context = _extBuildContext;
  Widget _keypadButton(
      String _buttonID, String _buttonType, String _buttonValue) {
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
              child: Text(
                _buttonValue,
                style: _buttonType == 'num'
                    ? Theme.of(context).accentTextTheme.headline4
                    : TextStyle(
                        fontFamily: 'MaterialIcons',
                        fontSize: 46,
                      ),
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

class QuickMathGameDisplay extends StatefulWidget {
  const QuickMathGameDisplay({Key? key}) : super(key: key);
  @override
  _QuickMathGameDisplayState createState() => _QuickMathGameDisplayState();
}

class _QuickMathGameDisplayState extends State<QuickMathGameDisplay> {
  Random random = Random(DateTime.now().millisecondsSinceEpoch);

  String _question = 'Press Start';
  String _answerNumber = '';
  int _answerActualNumber = 0;

  String _answerBoxNumber = '';
  int _currentLevel = 0;

  int maxLevel = 15;
  int _score = 0;
  double _counter = 90;

  Timer _timer = Timer.periodic(
      Duration(
        days: 1,
      ),
      (timer) => {});
  bool _finished = false;

  int _limL = 1, _limR = 9;
  int _getRandomNumber() {
    int len = _limR - _limL + 1;
    return _limL + random.nextInt(len);
  }

  void _generateNumberForLevel(int _level) {
    int num1 = _getRandomNumber();
    int num2 = _getRandomNumber();
    if (num1 > num2) {
      int tmp = num1;
      num1 = num2;
      num2 = tmp;
    }
    _answerActualNumber = num1 + num2;
    _answerNumber = _answerActualNumber.toString();
    _question = num1.toString() + ' + ' + num2.toString();
    if (_level % 5 == 0) {
      _limL *= 10;
      _limR = _limR * 10 + 9;
    }
  }

  void _newLevel() {
    _answerBoxNumber = '';
    _currentLevel++;
    _generateNumberForLevel(_currentLevel);
    _secondaryReactionStream.sendData('update');
  }

  int _getPointPerLevel(int _level, int _number) {
    return _level;
  }

  void _onStreamUpdate(String _value) {
    if (_value[0] == '-') {
      if (_value == '-backspace') {
        if (_answerBoxNumber.isNotEmpty) {
          _answerBoxNumber =
              _answerBoxNumber.substring(0, _answerBoxNumber.length - 1);
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
    _secondaryReactionStream.sendData('update');
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
    _question = 'Done';
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
                            return Text(
                              _question,
                              style: Theme.of(context).textTheme.headline3,
                            );
                          }),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: StreamBuilder<String>(
                        stream: _scoreUpdateStream.stream,
                        builder: (context, snapshot) {
                          return Text(
                            _score.toString() + 'pts',
                            style: Theme.of(context).textTheme.headline6,
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: StreamBuilder<String>(
                        stream: _timerUpdateStream.stream,
                        builder: (context, snapshot) {
                          return Text(
                            _counter.toString() + 's',
                            style: Theme.of(context).textTheme.headline6,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
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
                        return Text(
                          _answerBoxNumber,
                          style: Theme.of(context).textTheme.headline4,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
