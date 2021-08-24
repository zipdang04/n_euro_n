import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:n_euro_n/module/core/personalProgressHandler.dart';
import 'ChemicalEquationData.dart';

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

StringUpdateStream _reactionStream = new StringUpdateStream();
StringUpdateStream _secondaryReactionStream = new StringUpdateStream();
StringUpdateStream _timerUpdateStream = new StringUpdateStream();
StringUpdateStream _scoreUpdateStream = new StringUpdateStream();
StringUpdateStream _endGameStream = new StringUpdateStream();
var _extBuildContext;

void _closeStreams() {
  _reactionStream.dispose();
  _secondaryReactionStream.dispose();
  _timerUpdateStream.dispose();
  _scoreUpdateStream.dispose();
  _endGameStream.dispose();
}

void _openStreams() {
  _reactionStream = new StringUpdateStream();
  _secondaryReactionStream = new StringUpdateStream();
  _timerUpdateStream = new StringUpdateStream();
  _scoreUpdateStream = new StringUpdateStream();
  _endGameStream = new StringUpdateStream();
}
class ChemicalEquationGameScreen extends StatelessWidget {
  const ChemicalEquationGameScreen({Key? key}) : super(key: key);
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
              ChemicalEquationGameDisplay(),
              ChemicalEquationGameKeypad(context: context),
            ],
          ),
        ),
      ),
    );
  }
}

class ChemicalEquationGameKeypad extends StatelessWidget {
  ChemicalEquationGameKeypad({Key? key, required BuildContext context})
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

class ChemicalEquationGameDisplay extends StatefulWidget {
  const ChemicalEquationGameDisplay({Key? key}) : super(key: key);
  @override
  _ChemicalEquationGameDisplayState createState() => _ChemicalEquationGameDisplayState();
}

class _ChemicalEquationGameDisplayState extends State<ChemicalEquationGameDisplay> {
  Random random = Random(DateTime.now().millisecondsSinceEpoch);

  String _question = 'Press Start';
  String _answerNumber = '';
  int _answerActualNumber = 0;
  String _answerBoxNumber = '';

  int _currentLevel = 0;
  int maxLevel = 100;
  int _score = 0;

  static const double _time = 90;
  double _counter = _time;
  Timer _timer = Timer.periodic(
      Duration(
        days: 1,
      ),
          (timer) => {});
  bool _finished = false;

  int _limL = 0, _limR = dataChemical.length-1;
  int _getRandomNumber() {
    int len = _limR - _limL + 1;
    return _limL + random.nextInt(len);
  }

  void _generateNumberForLevel(int _level) {
    equationChemical _chemicalQuestion = getChemicalQuestion();

    int _i = _getRandomNumber();

    _answerNumber = _chemicalQuestion.getAnswerChemical();
    _question = _chemicalQuestion.getQuestionChemical();
  }

  void _newLevel() {
    _answerNumber = '';
    _secondaryReactionStream.sendData('update');
    _answerBoxNumber = '';
    _currentLevel++;
    _generateNumberForLevel(_currentLevel);
    _secondaryReactionStream.sendData('update');
  }

  int _getPointPerLevel(int _level, int _number) {
    return _level;
  }

  int _getFinalScore(int _currentScore, double _timeLeft) {
    return _currentScore * 100 + _timeLeft.round();
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
    } else if (_answerBoxNumber.length < 16) {
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
    _counter = _time + 0.5;
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
        if (_counter >= _time) {
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
    addGameToHistory('Chemical Equation', _getFinalScore(_score, _counter));
    _finished = true;
    _question = 'Done';
    _secondaryReactionStream.sendData('update');
    _answerBoxNumber =
        'Final score: ' + _getFinalScore(_score, _counter).toString();
    _reactionStream.sendData('-delete');
    _timer.cancel();
    _timerUpdateStream.sendData('update');
    _endGameStream.sendData('update');
    //Navigator.pop(context);
    //_closeStreams();
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostGameScreen(playerScore: _score,)),
    );*/
    _reactionStream.dispose();
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
                              style: Theme.of(context).textTheme.headline6,
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
                          //_answerBoxNumber = '';
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          //_answerBoxNumber = '';
                        } else if (snapshot.hasError) {
                          _answerBoxNumber = 'Error encountered';
                        } else {
                          String _value = snapshot.data.toString();
                          //_onStreamUpdate(_value);
                          if (_counter <= _time) {
                            _onStreamUpdate(_value);
                          }
                        }
                        if (_counter > _time) {
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
  @override
  void dispose() {
    if (_finished) {
      return;
    }
    _finished = true;
    _answerNumber = 'Done';
    _secondaryReactionStream.sendData('update');
    _answerBoxNumber = '';
    _reactionStream.sendData('-delete');
    _timer.cancel();
    _timerUpdateStream.sendData('update');
    _endGameStream.sendData('update');
    //_closeStreams();
    _reactionStream.dispose();
    print('Game closed before finished');
    super.dispose();
  }
}