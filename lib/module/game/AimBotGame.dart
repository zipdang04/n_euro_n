import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:n_euro_n/module/core/personalProgressHandler.dart';

int level = 0, _finalScore = 0, _publicScore = 0, _timeLeft = 0;

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
StringUpdateStream _startGameStream = new StringUpdateStream();
var _extBuildContext;

void _closeStreams() {
  _keypadDataStream.dispose();
  _screenUpdateStream.dispose();
  _timerUpdateStream.dispose();
  _scoreUpdateStream.dispose();
  _endGameStream.dispose();
  _startGameStream.dispose();
}

void _openStreams() {
  _keypadDataStream = new StringUpdateStream();
  _screenUpdateStream = new StringUpdateStream();
  _timerUpdateStream = new StringUpdateStream();
  _scoreUpdateStream = new StringUpdateStream();
  _endGameStream = new StringUpdateStream();
  _startGameStream = new StringUpdateStream();
}

class AimBotGameScreen extends StatelessWidget {
  const AimBotGameScreen({Key? key}) : super(key: key);
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
              AimBotGameDisplay(),
            ],
          ),
        ),
      ),
    );
  }
}

class AimBotGameDisplay extends StatefulWidget {
  const AimBotGameDisplay({Key? key}) : super(key: key);
  @override
  _AimBotGameDisplayState createState() => _AimBotGameDisplayState();
}

class _AimBotGameDisplayState extends State<AimBotGameDisplay> {
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
  // int _getPointPerLevel(int _level, int _number) {
  //   return _level;
  // }
  int _getFinalScore(int _currentScore, double _timeLeft) {
    return _currentScore * 1 + _timeLeft.round();
  }
  // void _onKeypadStreamUpdate(String _value) {
  //   if (_value[0] == '-') {
  //     if (_value == '-backspace') {
  //       if (_answerBoxData.isNotEmpty) {
  //         _answerBoxData = _answerBoxData.substring(0, _answerBoxData.length - 1);
  //       }
  //     } else if (_value == '-delete') {
  //       _answerBoxData = '';
  //     } else if (_value == '-restart') {
  //       _currentLevel = 0;
  //       _startGame();
  //     } else if (_value == '-update') {
  //       _answerBoxData = _answerBoxData;
  //     }
  //   } else if (_answerBoxData.length < 16) {
  //     _answerBoxData += _value;
  //   }
  //   if (_screenDisplayData == _answerBoxData) {
  //     _score += _getPointPerLevel(_currentLevel, _correctAnswerNumber);
  //     if (_currentLevel < _maxLevel) {
  //       _newLevel();
  //     } else {
  //       _endGame();
  //     }
  //     _screenUpdateStream.sendData('update');
  //     _scoreUpdateStream.sendData('update');
  //   }
  //   _screenUpdateStream.sendData('update');
  // }
  void _startGame() {
    _counter = 90;
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
    level = -1;
    _startGameStream.sendData('update');
    if (_finished) {
      return;
    }
    _finished = true;
    _finalScore = _getFinalScore(_score, _counter);
    addGameToHistory('Quick Press', _finalScore);
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
                    /*Center(
                      child: Wrapper(), ///////////////////////////////////////////////////////////////
                    ),*/
                    Container(
                      // Score
                      alignment: Alignment.center,
                      child: StreamBuilder<String>(
                        stream: _startGameStream.stream,
                        builder: (context, snapshot) {
                          return Wrapper();
                        },
                      ),
                    ),
                    Container(
                      // Score
                      alignment: Alignment.topLeft,
                      child: StreamBuilder<String>(
                        stream: _scoreUpdateStream.stream,
                        builder: (context, snapshot) {
                          _score = _publicScore;
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
        ],
      ),
    );
  }
  @override
  void dispose() {
    level = _publicScore = 0;
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

  Widget Wrapper() {
    if (level == 0) {
      return ElevatedButton(
        onPressed: () {
          _startGame();
          _startGameStream.sendData('update');
          ++level;
        },
        child: Text('Start', style: Theme.of(context).textTheme.headline2,),
      );
    } else if (level == -1) {
      return Center(
        child: Column(
          children: [
            Expanded(child: Container()),
            Text('Done', style: Theme.of(context).textTheme.headline3,),
            SizedBox(height: 16,),
            Text('Final score: ' + _finalScore.toString(), style: Theme.of(context).textTheme.headline4,),
            Expanded(child: Container()),
          ],
        ),
      );
    } else {
      return aimBotLevel();
    }
  }
}

class aimBotLevel extends StatefulWidget {
  const aimBotLevel({Key? key}) : super(key: key);

  @override
  _aimBotLevelState createState() => _aimBotLevelState();
}

class _aimBotLevelState extends State<aimBotLevel> {
  var x, y, rng = new Random();

  @override
  Widget build(BuildContext context) {
    var x = rng.nextInt(100) + 1;
    var y = rng.nextInt(100) + 1;

    return Container(
        margin: EdgeInsets.only(top: 35),
        //color: Colors.red,
        child: Column(
          children: [
            Expanded(
              child: Container(),
              flex: x,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(),
                  flex: y,
                ),
                ElevatedButton(
                  child: Icon(Icons.add, size: 50,),
                  onPressed: () {
                    setState(() {
                      ++level;
                      _publicScore += 1 + (level / 12).floor();
                      _scoreUpdateStream.sendData('update');
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                  ),
                ),
                Expanded(
                  child: Container(),
                  flex: 100 - y,
                ),
              ],
            ),
            Expanded(
              child: Container(),
              flex: 100 - x,
            ),
          ],
        )
    );
  }
}

