import 'package:flutter/material.dart';
import 'numberTypeSpeedGameReborn.dart';
import 'quickMathGame.dart';
import 'ChemicalEquationGame.dart';
import 'numberSequenceMemoryGame.dart';
import 'numberPile.dart';
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

Widget getNumberPile(){
  return NumberPileGameScreen();
}