import 'package:flutter/material.dart';
import 'numberTypeSpeedGame.dart';
import 'quickMathGame.dart';
import 'ChemicalEquationGame.dart';
import 'numberSequenceMemoryGame.dart';

Widget getGameNumberTypeSpeed() {
  return NumberTypeSpeedGameScreen();
}

Widget getQuickMath(){
  return QuickMathGameScreen();
}

Widget getChemicalEquation() {
  return ChemicalEquationGameScreen();
}

Widget getGameNumberSequenceMemory() {
  return NumberSequenceMemoryGameScreen();
}