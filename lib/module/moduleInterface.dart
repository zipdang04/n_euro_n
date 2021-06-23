import 'package:flutter/material.dart';
import 'core/homeScaffold.dart';
import 'core/appTheme.dart';
import 'screen/homeScreen.dart';
import 'screen/allExerciseScreen.dart';
import 'screen/pregameScreen.dart';
import 'core/exerciseHandler.dart';

Widget getHomeScaffold() {
  return HomeScaffold();
}

ThemeData getAppTheme(BuildContext context) {
  return pickAppTheme(context);
}

Widget getHomeScreen() {
  return HomeScreen();
}

Widget getAllExerciseScreen() {
  return AllExerciseScreen();
}

Widget getPreGameScreen(Exercise _exercise) {
  return PreGameScreen(exercise: _exercise,);
}