import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';

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
var _extBuildContext;

void _closeStreams() {
  _reactionStream.dispose();
  _secondaryReactionStream.dispose();
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
  QuickMathGameKeypad({Key? key, required BuildContext context}) : super(key: key);
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

class QuickMathGameDisplay extends StatefulWidget {
  const QuickMathGameDisplay({Key? key}) : super(key: key);
  @override
  _QuickMathGameDisplayState createState() => _QuickMathGameDisplayState();
}

class _QuickMathGameDisplayState extends State<QuickMathGameDisplay> {
  Random random = Random(DateTime.now().millisecondsSinceEpoch);

  String _answerNumber = '';
  String _answerBoxNumber = '';
  String _question = '';
  
  int _currentLevel = 0;
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

    _answerNumber = (num1 + num2).toString();
    _question = num1.toString() + ' + ' +  num2.toString();
  }
  
  void _newLevel() {
    _answerBoxNumber = '';
    _currentLevel++;
    _generateNumberForLevel(_currentLevel);
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
        _newLevel();
      }
    } else {
      _answerBoxNumber += _value;
    }
    if (_answerNumber == _answerBoxNumber) {
      if (_currentLevel < maxLevel) {
        _newLevel();
      } else {
        _question = 'Done';
      }
    }
    _secondaryReactionStream.sendData('update');
  }
  @override
  Widget build(BuildContext context) {
    //_newLevel();
    //return Container(height: 200, width: 200, color: Colors.red,);
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Card(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Center(
                  //child: Text(_answerNumber, style: Theme.of(context).textTheme.headline3,),
                  child: StreamBuilder<String>(
                    stream: _secondaryReactionStream.stream,
                    builder: (context, snapshot) {
                      return Text(_question, style: Theme.of(context).textTheme.headline3,);
                    }
                  ),
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
                          _onStreamUpdate(_value);
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


// class QuickMathGameScreen extends StatefulWidget {
//   const QuickMathGameScreen({Key? key}) : super(key: key);
//   @override
//   _QuickMathGameScreenState createState() => _QuickMathGameScreenState(startingPoint: 0);
// }

// class _QuickMathGameScreenState extends State<QuickMathGameScreen> {
//   _QuickMathGameScreenState({required this.startingPoint});
//   Random random = Random(DateTime.now().millisecondsSinceEpoch);
//   int startingPoint;
//   String _question = '1';
//   String _answerNumber = '1';
//   String _answerBoxNumber = '1';
//   int _currentLevel = -1;
//   int maxLevel = 5;





//   void _newLevel() {
//     _answerBoxNumber = '';
//     _currentLevel++;
//     _generateNumberForLevel(_currentLevel);
//   }
  
//   Widget _keypadButton(String _buttonID, String _buttonType, String _buttonValue) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             if (_buttonType == 'num') {
//               _answerBoxNumber += _buttonValue;
//             } else {
//               if (_buttonID == 'backspace') {
//                 _answerBoxNumber = _answerBoxNumber.substring(0, _answerBoxNumber.length - 1);
//               } else if (_buttonID == 'delete') {
//                 _answerBoxNumber = '';
//               } else if (_buttonID == 'restart') {
//                 _currentLevel = 0;
//                 _newLevel();
//               }
//             }
//             if (_answerNumber == _answerBoxNumber) {
//               if (_currentLevel < maxLevel) {
//                 _newLevel();
//               } else {
//                 _question = 'Done';
//               }
//             }
//           });
//         },
//         child: Card(
//           color: Theme.of(context).cardColor,
//           child: Container(
//             padding: EdgeInsets.all(8),
//             child: Center(
//               child: Text(_buttonValue,
//                 style: _buttonType == 'num' ? Theme.of(context).accentTextTheme.headline4 : TextStyle(fontFamily: 'MaterialIcons', fontSize: 46,),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     if (_currentLevel < 0) {
//       _currentLevel = startingPoint;
//       _newLevel();
//     }
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(16),
//           child: Expanded(
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Card(
//                     child: Container(
//                       padding: EdgeInsets.all(8),
//                       child: Center(
//                         child: Text(_question, style: Theme.of(context).textTheme.headline3,),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16,),
//                 Container(
//                   height: 80,
//                   child: Expanded(
//                     child: Card(
//                       child: Container(
//                         padding: EdgeInsets.all(8),
//                         child: Center(
//                           child: Text(_answerBoxNumber, style: Theme.of(context).textTheme.headline4,),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16,),
//                 Container(
//                   height: 300,
//                   child: Expanded(
//                     child: Card(
//                       child: Container(
//                         padding: EdgeInsets.all(8),
//                         child: Center(
//                           child: Table(
//                             children: [
//                               TableRow(children: [
//                                 _keypadButton('1', 'num', '1'),
//                                 _keypadButton('2', 'num', '2'),
//                                 _keypadButton('3', 'num', '3'),
//                               ]),
//                               TableRow(children: [
//                                 _keypadButton('4', 'num', '4'),
//                                 _keypadButton('5', 'num', '5'),
//                                 _keypadButton('6', 'num', '6'),
//                               ]),
//                               TableRow(children: [
//                                 _keypadButton('7', 'num', '7'),
//                                 _keypadButton('8', 'num', '8'),
//                                 _keypadButton('9', 'num', '9'),
//                               ]),
//                               TableRow(children: [
//                                 _keypadButton('restart', 'special', 'delete'),
//                                 _keypadButton('0', 'num', '0'),
//                                 _keypadButton('backspace', 'special', 'backspace'),
//                               ]),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }