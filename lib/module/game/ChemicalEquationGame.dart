import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

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

class _equationChemical {
  String _questionChemical = '';
  int _answerChemical = 0;

  _equationChemical(this._questionChemical, this._answerChemical);

  String getQuestionChemical() {
    return _questionChemical;
  }

  int getAnswerChemical() {
    return _answerChemical;
  }
}

List<_equationChemical> _dataChemical = [
  _equationChemical('1Ba + 2Na -> ?BaNaNa', 1),//1 2 1
  _equationChemical('?Mg + 1O2 -> 2MgO', 2),
  _equationChemical('2Mg + ?O2 -> 2MgO', 1),
  _equationChemical('2Mg + 1O2 -> ?MgO', 2),
  _equationChemical('?P + 5O2 -> 2P2O5', 4),
  _equationChemical('4P + ?O2 -> 2P2O5', 5),
  _equationChemical('4P + 5O2 -> ?P2O5', 2),
  _equationChemical('?KClO3 -> 2KCl + 3O2', 2),
  _equationChemical('2KClO3 -> ?KCl + 3O2', 2),
  _equationChemical('2KClO3 -> 2KCl + ?O2', 3),
  _equationChemical('?HCl + 2KMnO4 -> 2MnCl2 + 2KCl + 5Cl2 + 8H2O', 16),
  _equationChemical('16HCl + ?KMnO4 -> 2MnCl2 + 2KCl + 5Cl2 + 8H2O', 2),
  _equationChemical('16HCl + 2KMnO4 -> ?MnCl2 + 2KCl + 5Cl2 + 8H2O', 2),
  _equationChemical('16HCl + 2KMnO4 -> 2MnCl2 + ?KCl + 5Cl2 + 8H2O', 2),
  _equationChemical('16HCl + 2KMnO4 -> 2MnCl2 + 2KCl + ?Cl2 + 8H2O', 5),
  _equationChemical('16HCl + 2KMnO4 -> 2MnCl2 + 2KCl + 5Cl2 + ?H2O', 8),
  _equationChemical('?C12H22O11 + 1H2O -> 2C6H12O6', 1),
  _equationChemical('1C12H22O11 + ?H2O -> 2C6H12O6', 1),
  _equationChemical('1C12H22O11 + 1H2O -> ?C6H12O6', 2),
  _equationChemical('?C12H22O11 + 12O2 -> 12CO2 + 11H2O', 1),
  _equationChemical('1C12H22O11 + ?O2 -> 12CO2 + 11H2O', 12),
  _equationChemical('1C12H22O11 + 12O2 -> ?CO2 + 11H2O', 12),
  _equationChemical('1C12H22O11 + 12O2 -> 12CO2 + ?H2O', 11),
  _equationChemical('?C6H5CHCH2 + 10KMnO4 -> 3C6H5COOK + 3K2CO3 + 1KOH + 10MnO2 + 4H2O', 3),// 3 10 3 3 1 10 4
  _equationChemical('3C6H5CHCH2 + ?KMnO4 -> 3C6H5COOK + 3K2CO3 + 1KOH + 10MnO2 + 4H2O', 10),
  _equationChemical('3C6H5CHCH2 + 10KMnO4 -> ?C6H5COOK + 3K2CO3 + 1KOH + 10MnO2 + 4H2O', 3),
  _equationChemical('3C6H5CHCH2 + 10KMnO4 -> 3C6H5COOK + ?K2CO3 + 1KOH + 10MnO2 + 4H2O', 3),
  _equationChemical('3C6H5CHCH2 + 10KMnO4 -> 3C6H5COOK + 3K2CO3 + ?KOH + 10MnO2 + 4H2O', 1),
  _equationChemical('3C6H5CHCH2 + 10KMnO4 -> 3C6H5COOK + 3K2CO3 + 1KOH + ?MnO2 + 4H2O', 10),
  _equationChemical('3C6H5CHCH2 + 10KMnO4 -> 3C6H5COOK + 3K2CO3 + 1KOH + 10MnO2 + ?H2O', 4),
  _equationChemical('?C2H5OH -> 1C2H4 + 1H2O', 1),// 1 1 1
  _equationChemical('1C2H5OH -> ?C2H4 + 1H2O', 1),
  _equationChemical('1C2H5OH -> 1C2H4 + ?H2O', 1),
  _equationChemical('?C2H5OH + 1CH3COOH <-> 1CH3COOC2H5 + 1H2O', 1),// 1 1 1 1
  _equationChemical('1C2H5OH + ?CH3COOH <-> 1CH3COOC2H5 + 1H2O', 1),
  _equationChemical('1C2H5OH + 1CH3COOH <-> ?CH3COOC2H5 + 1H2O', 1),
  _equationChemical('1C2H5OH + 1CH3COOH <-> 1CH3COOC2H5 + ?H2O', 1),
  _equationChemical('?C2H5OH + 2Na -> 2C2H5ONa + 1H2', 2),// 2 2 2 1
  _equationChemical('2C2H5OH + ?Na -> 2C2H5ONa + 1H2', 2),
  _equationChemical('2C2H5OH + 2Na -> ?C2H5ONa + 1H2', 2),
  _equationChemical('2C2H5OH + 2Na -> 2C2H5ONa + ?H2', 1),
  _equationChemical('?H2SO4 + 1KClO4 -> 1HClO4 + 1KHSO4', 1),// 1 1 1 1
  _equationChemical('1H2SO4 + ?KClO4 -> 1HClO4 + 1KHSO4', 1),
  _equationChemical('1H2SO4 + 1KClO4 -> ?HClO4 + 1KHSO4', 1),
  _equationChemical('1H2SO4 + 1KClO4 -> 1HClO4 + ?KHSO4', 1),
  _equationChemical('?KMnO4 + 3C2H4 + 4H2O -> 4C2H4(OH)2 + 2KOH + 2MnO2', 1),// 1 3 4 4 2 2
  _equationChemical('1KMnO4 + ?C2H4 + 4H2O -> 4C2H4(OH)2 + 2KOH + 2MnO2', 3),
  _equationChemical('1KMnO4 + 3C2H4 + ?H2O -> 4C2H4(OH)2 + 2KOH + 2MnO2', 4),
  _equationChemical('1KMnO4 + 3C2H4 + 4H2O -> ?C2H4(OH)2 + 2KOH + 2MnO2', 4),
  _equationChemical('1KMnO4 + 3C2H4 + 4H2O -> 4C2H4(OH)2 + ?KOH + 2MnO2', 2),
  _equationChemical('1KMnO4 + 3C2H4 + 4H2O -> 4C2H4(OH)2 + 2KOH + ?MnO2', 2),
  _equationChemical('?HCHO + 2Br2 + 1H2O -> 2HBr + 1CO2', 1),// 1 2 1 1 2
  _equationChemical('1HCHO + ?Br2 + 1H2O -> 2HBr + 1CO2', 2),
  _equationChemical('1HCHO + 2Br2 + ?H2O -> 2HBr + 1CO2', 1),
  _equationChemical('1HCHO + 2Br2 + 1H2O -> ?HBr + 1CO2', 1),
  _equationChemical('1HCHO + 2Br2 + 1H2O -> 2HBr + ?CO2', 2),
  _equationChemical('?AgNO3 + 1H2O + 4NH3 + 1HCOOH -> 1(NH4)2CO3 + 2Ag + 2NH4NO3', 2),//2 1 4 1 1 2 2
  _equationChemical('2AgNO3 + ?H2O + 4NH3 + 1HCOOH -> 1(NH4)2CO3 + 2Ag + 2NH4NO3', 1),
  _equationChemical('2AgNO3 + 1H2O + ?NH3 + 1HCOOH -> 1(NH4)2CO3 + 2Ag + 2NH4NO3', 4),
  _equationChemical('2AgNO3 + 1H2O + 4NH3 + ?HCOOH -> 1(NH4)2CO3 + 2Ag + 2NH4NO3', 1),
  _equationChemical('2AgNO3 + 1H2O + 4NH3 + 1HCOOH -> ?(NH4)2CO3 + 2Ag + 2NH4NO3', 1),
  _equationChemical('2AgNO3 + 1H2O + 4NH3 + 1HCOOH -> 1(NH4)2CO3 + ?Ag + 2NH4NO3', 2),
  _equationChemical('2AgNO3 + 1H2O + 4NH3 + 1HCOOH -> 1(NH4)2CO3 + 2Ag + ?NH4NO3', 2),
  _equationChemical('?O2 + 1C2H4O2 -> 2H2O + 2CO2', 2),// 2 1 2 2
  _equationChemical('2O2 + ?C2H4O2 -> 2H2O + 2CO2', 1),
  _equationChemical('2O2 + 1C2H4O2 -> ?H2O + 2CO2', 2),
  _equationChemical('2O2 + 1C2H4O2 -> 2H2O + ?CO2', 2),
  _equationChemical('?C2H5OH + 1C2H4O2 -> 3H2O + 2C4H8O', 3),//3 1 3 2
  _equationChemical('3C2H5OH + ?C2H4O2 -> 3H2O + 2C4H8O', 1),
  _equationChemical('3C2H5OH + 1C2H4O2 -> ?H2O + 2C4H8O', 3),
  _equationChemical('3C2H5OH + 1C2H4O2 -> 3H2O + ?C4H8O', 2),
  _equationChemical('?C6H6 + 3Cl -> 1C6H6Cl6', 1),// 1 3 1
  _equationChemical('1C6H6 + ?Cl -> 1C6H6Cl6', 3),
  _equationChemical('1C6H6 + 3Cl -> ?C6H6Cl6', 1),
  _equationChemical('?H2 + 1C6H5CHCH2 -> 1C6H5CH2CH3', 1),// 1 1 1
  _equationChemical('1H2 + ?C6H5CHCH2 -> 1C6H5CH2CH3', 1),
  _equationChemical('1H2 + 1C6H5CHCH2 -> ?C6H5CH2CH3', 1),
  _equationChemical('?H2SO4 + 1Ba(AlO2)2 + -> 1Al2(SO4)3 + 4H2O + 1BaSO4', 4),//4 1 1 4 1
  _equationChemical('4H2SO4 + ?Ba(AlO2)2 + -> 1Al2(SO4)3 + 4H2O + 1BaSO4', 1),
  _equationChemical('4H2SO4 + 1Ba(AlO2)2 + -> ?Al2(SO4)3 + 4H2O + 1BaSO4', 1),
  _equationChemical('4H2SO4 + 1Ba(AlO2)2 + -> 1Al2(SO4)3 + ?H2O + 1BaSO4', 4),
  _equationChemical('4H2SO4 + 1Ba(AlO2)2 + -> 1Al2(SO4)3 + 4H2O + ?BaSO4', 1),
  _equationChemical('?H2O + 2NaHSO4 + 1Ba(AlO2)2 -> 2Al(OH)3 + 1Na2SO4 + 1BaSO4', 2),//2 2 1 2 1 1
  _equationChemical('2H2O + ?NaHSO4 + 1Ba(AlO2)2 -> 2Al(OH)3 + 1Na2SO4 + 1BaSO4', 2),
  _equationChemical('2H2O + 2NaHSO4 + ?Ba(AlO2)2 -> 2Al(OH)3 + 1Na2SO4 + 1BaSO4', 1),
  _equationChemical('2H2O + 2NaHSO4 + 1Ba(AlO2)2 -> ?Al(OH)3 + 1Na2SO4 + 1BaSO4', 2),
  _equationChemical('2H2O + 2NaHSO4 + 1Ba(AlO2)2 -> 2Al(OH)3 + ?Na2SO4 + 1BaSO4', 1),
  _equationChemical('2H2O + 2NaHSO4 + 1Ba(AlO2)2 -> 2Al(OH)3 + 1Na2SO4 + ?BaSO4', 1),
  _equationChemical('?Ba(AlO2)2 + 1Na2CO3 + 4H2O -> 1BaCO3 + 2Al(OH)3 + 2NaOH', 1),//1 1 4 1 2 2
  _equationChemical('1Ba(AlO2)2 + ?Na2CO3 + 4H2O -> 1BaCO3 + 2Al(OH)3 + 2NaOH', 1),
  _equationChemical('1Ba(AlO2)2 + 1Na2CO3 + ?H2O -> 1BaCO3 + 2Al(OH)3 + 2NaOH', 4),
  _equationChemical('1Ba(AlO2)2 + 1Na2CO3 + 4H2O -> ?BaCO3 + 2Al(OH)3 + 2NaOH', 1),
  _equationChemical('1Ba(AlO2)2 + 1Na2CO3 + 4H2O -> 1BaCO3 + ?Al(OH)3 + 2NaOH', 2),
  _equationChemical('1Ba(AlO2)2 + 1Na2CO3 + 4H2O -> 1BaCO3 + 2Al(OH)3 + ?NaOH', 2),
  _equationChemical('?H2O + 3Na2CO3 + 2FeCl3 -> 6NaCl + 3CO2 + 2Fe(OH)3', 3),//3 3 2 6 3 2
  _equationChemical('3H2O + ?Na2CO3 + 2FeCl3 -> 6NaCl + 3CO2 + 2Fe(OH)3', 3),
  _equationChemical('3H2O + 3Na2CO3 + ?FeCl3 -> 6NaCl + 3CO2 + 2Fe(OH)3', 2),
  _equationChemical('3H2O + 3Na2CO3 + 2FeCl3 -> ?NaCl + 3CO2 + 2Fe(OH)3', 6),
  _equationChemical('3H2O + 3Na2CO3 + 2FeCl3 -> 6NaCl + ?CO2 + 2Fe(OH)3', 3),
  _equationChemical('3H2O + 3Na2CO3 + 2FeCl3 -> 6NaCl + 3CO2 + ?Fe(OH)3', 2),
  _equationChemical('?NaOH + 1CuCl2 -> 1Cu(OH)2 + 2NaCl', 2),
]; // den dong 156, gom 101 PTHH

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

  int _limL = 0, _limR = 100;
  int _getRandomNumber() {
    int len = _limR - _limL + 1;
    return _limL + random.nextInt(len);
  }

  void _generateNumberForLevel(int _level) {
    int _i = _getRandomNumber();

    _answerNumber = _dataChemical[_i].getAnswerChemical().toString();
    _question = _dataChemical[_i].getQuestionChemical();
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
}