import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'module/moduleInterface.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final _license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], _license);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'N_EURO_N UI Demo',
      theme: getAppTheme(context),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: getHomeScaffold(),
    );
  }
}