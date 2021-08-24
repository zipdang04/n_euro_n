import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:n_euro_n/module/core/personalProgressHandler.dart';

class StringUpdateStream {
  final _controller = StreamController<String>.broadcast();
  Stream<String> get stream => _controller.stream;
  void sendData(String _data) {
    _controller.sink.add(_data);
  }
  void dispose() {
    _controller.close();
  }
}

StringUpdateStream _keypadDataStream = new StringUpdateStream();
StringUpdateStream _screenUpdateStream = new StringUpdateStream();
StringUpdateStream _timerUpdateStream = new StringUpdateStream();
StringUpdateStream _scoreUpdateStream = new StringUpdateStream();
StringUpdateStream _endGameStream = new StringUpdateStream();
var _extBuildContext;

void _closeStreams() {
  _keypadDataStream.dispose();
  _screenUpdateStream.dispose();
  _timerUpdateStream.dispose();
  _scoreUpdateStream.dispose();
  _endGameStream.dispose();
}

void _openStreams() {
  _keypadDataStream = new StringUpdateStream();
  _screenUpdateStream = new StringUpdateStream();
  _timerUpdateStream = new StringUpdateStream();
  _scoreUpdateStream = new StringUpdateStream();
  _endGameStream = new StringUpdateStream();
}

class NumberTypeSpeedGameScreen extends StatelessWidget {
  const NumberTypeSpeedGameScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _extBuildContext = context;
    _closeStreams();
    _openStreams();
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
          _keypadDataStream.sendData(_buttonID);
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
  String _screenDisplayData = 'Press Start';
  int _correctAnswerNumber = 0;
  String _answerBoxData = '';
  int _currentLevel = 0;
  int _maxLevel = 200;
  int _score = 0;
  double _counter = 90;
  Timer _timer = Timer.periodic(Duration(days: 1,), (timer) => {});
  bool _finished = false;
  int _generateNumberForLevel(int _level) {
    //print(_level);
    Random _random = Random();
    int _randomNumber = _random.nextInt(100 + _level * 200) + _level * 150 + _random.nextInt(10) + _random.nextInt(100);
    return _randomNumber;
  }
  void _newLevel() {
    _screenDisplayData = '';
    _screenUpdateStream.sendData('update');
    _answerBoxData = '';
    _currentLevel++;
    _correctAnswerNumber = _generateNumberForLevel(_currentLevel);
    _screenDisplayData = _correctAnswerNumber.toString();
    _screenUpdateStream.sendData('update');
  }
  int _getPointPerLevel(int _level, int _number) {
    return _level;
  }
  int _getFinalScore(int _currentScore, double _timeLeft) {
    return _currentScore * 1 + _timeLeft.round();
  }
  void _onKeypadStreamUpdate(String _value) {
    if (_value[0] == '-') {
      if (_value == '-backspace') {
        if (_answerBoxData.isNotEmpty) {
          _answerBoxData = _answerBoxData.substring(0, _answerBoxData.length - 1);
        }
      } else if (_value == '-delete') {
        _answerBoxData = '';
      } else if (_value == '-restart') {
        _currentLevel = 0;
        _startGame();
      } else if (_value == '-update') {
        _answerBoxData = _answerBoxData;
      }
    } else if (_answerBoxData.length < 16) {
      _answerBoxData += _value;
    }
    if (_screenDisplayData == _answerBoxData) {
      _score += _getPointPerLevel(_currentLevel, _correctAnswerNumber);
      if (_currentLevel < _maxLevel) {
        _newLevel();
      } else {
        _endGame();
      }
      _screenUpdateStream.sendData('update');
      _scoreUpdateStream.sendData('update');
    }
    _screenUpdateStream.sendData('update');
  }
  void _startGame() {
    _counter = 91;
    _score = 0;
    _scoreUpdateStream.sendData('update');
    _newLevel();
    if (_timer.isActive) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_counter > 0) {
        _counter -= 0.1;
        _counter = (_counter * 10).round() / 10;
        if (_counter >= 90) {
          _keypadDataStream.sendData('-delete');
        }
        _timerUpdateStream.sendData('update');
      } else if (_counter == 0) {
        _endGame();
      }
    });
  }
  void _endGame() async {
    if (_finished) {
      return;
    }
    _finished = true;
    int _finalScore = _getFinalScore(_score, _counter);
    addGameToHistory('Number Type Speed', _finalScore);
    // USE THE SAME NAME FROM THE ExerciseHandler.dart FILE
    _screenDisplayData = 'Done';
    _screenUpdateStream.sendData('update');
    _answerBoxData = 'Final score: ' + _finalScore.toString();
    _keypadDataStream.sendData('-update');
    _timer.cancel();
    _timerUpdateStream.sendData('update');
    _endGameStream.sendData('update');
    _keypadDataStream.dispose();
    //_closeStreams();
  }
  @override
  Widget build(BuildContext context) {
    _finished = false;
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
                      // Screen Display Data
                      child: StreamBuilder<String>(
                        stream: _screenUpdateStream.stream,
                        builder: (context, snapshot) {
                          return Text(_screenDisplayData, style: Theme.of(context).textTheme.headline3,);
                        }
                      ),
                    ),
                    Container(
                      // Score
                      alignment: Alignment.topLeft,
                      child: StreamBuilder<String>(
                        stream: _scoreUpdateStream.stream,
                        builder: (context, snapshot) {
                          return Text(_score.toString() + 'pts',
                            style: Theme.of(context).textTheme.headline6,
                          );
                        },
                      ),
                    ),
                    Container(
                        // Timer
                      alignment: Alignment.topRight,
                      child: StreamBuilder<String>(
                        stream: _timerUpdateStream.stream,
                        builder: (context, snapshot) {
                          return Text(_counter.toString() + 's',
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
          SizedBox(height: 16,),
          Container(
            height: 80,
            child: Expanded(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    // Answer Box
                    child: StreamBuilder<String>(
                      stream: _keypadDataStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          //_answerBoxData = '';
                        } else if (snapshot.connectionState == ConnectionState.done) {
                          //_answerBoxData = '';
                        } else if (snapshot.hasError) {
                          _answerBoxData = 'Error encountered';
                        } else {
                          String _value = snapshot.data.toString();
                          //_onKeypadStreamUpdate(_value);
                          if (_counter <= 90) {
                            _onKeypadStreamUpdate(_value);
                          }
                        }
                        if (_counter > 90) {
                          _answerBoxData = 'Locked';
                        } else if (_answerBoxData == 'Locked') {
                          _answerBoxData = '';
                        }
                        return Text(_answerBoxData, style: Theme.of(context).textTheme.headline4,);
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
  @override
  void dispose() {
    if (_finished) {
      return;
    }
    _finished = true;
    _screenDisplayData = 'Done';
    _screenUpdateStream.sendData('update');
    _answerBoxData = '';
    _keypadDataStream.sendData('-delete');
    _timer.cancel();
    _timerUpdateStream.sendData('update');
    _endGameStream.sendData('update');
    //_closeStreams();
    _keypadDataStream.dispose();
    print('Game closed before finished');
    super.dispose();
  }
}
