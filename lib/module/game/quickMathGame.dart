import 'dart:math';

import 'package:flutter/material.dart';

class QuickMathGameScreen extends StatefulWidget {
  const QuickMathGameScreen({Key? key}) : super(key: key);
  @override
  _QuickMathGameScreenState createState() => _QuickMathGameScreenState(startingPoint: 0);
}

class _QuickMathGameScreenState extends State<QuickMathGameScreen> {
  _QuickMathGameScreenState({required this.startingPoint});
  Random random = Random(DateTime.now().millisecondsSinceEpoch);
  int startingPoint;
  String _question = '1';
  String _answerNumber = '1';
  String _answerBoxNumber = '1';
  int _currentLevel = -1;
  int maxLevel = 5;

  int _getRandomNumber(int limL, int limR){
    int len = limR - limL + 1;
    return limL + random.nextInt(len);
  }

  void _generateNumberForLevel(int _level) {
    int limL = 1, limR = 100;
    
    int num1 = _getRandomNumber(limL, limR);
    int num2 = _getRandomNumber(limL, limR);
    if (num1 > num2) { int tmp = num1; num1 = num2; num2 = tmp; }

    _question = num1.toString() + ' + ' +  num2.toString();
    _answerNumber = (num1 + num2).toString();
  }

  void _newLevel() {
    _answerBoxNumber = '';
    _currentLevel++;
    _generateNumberForLevel(_currentLevel);
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
                _question = 'Done';
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
                        child: Text(_question, style: Theme.of(context).textTheme.headline3,),
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
