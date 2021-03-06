import 'package:flutter/material.dart';
import 'package:n_euro_n/module/game/AimBotGame.dart';
import 'numberTypeSpeedGameReborn.dart';
import 'quickMathGame.dart';
import 'ChemicalEquationGame/ChemicalEquationGame.dart';
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

Widget getAimBot() {
  return AimBotGameScreen();
}