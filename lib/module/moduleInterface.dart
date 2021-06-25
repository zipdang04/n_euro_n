import 'package:flutter/material.dart';
import 'core/homeScaffold.dart';
import 'core/appTheme.dart';
import 'screen/homeScreen.dart';
import 'screen/allExerciseScreen.dart';
import 'screen/pregameScreen.dart';
import 'core/exerciseHandler.dart';
import 'screen/settingScreen.dart';
import 'screen/personalProgressScreen.dart';
import 'screen/tournamentScreen.dart';

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
  return preGameScreen(exercise: _exercise,);
}

Widget getSettingScreen() {
  return SettingScreen();
}

Widget getPersonalProgressScreen() {
  return PersonalProgressScreen();
}

Widget getTournamentScreen() {
  return TournamentScreen();
}