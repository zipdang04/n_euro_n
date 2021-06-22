import 'package:flutter/material.dart';
import 'core/homeScaffold.dart';
import 'core/appTheme.dart';
import 'screen/homeScreen.dart';

Widget getHomeScaffold() {
  return HomeScaffold();
}

ThemeData getAppTheme(BuildContext context) {
  return pickAppTheme(context);
}

Widget getHomeScreen() {
  return HomeScreen();
}