import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'module/core/exerciseInstance/exerciseInstance.dart';
import 'module/moduleInterface.dart';
import 'module/core/personalProgressHandler.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter<ExerciseInstance>(ExerciseInstanceAdapter());
  await initBoxes();
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
      title: 'N_EURO_N',
      theme: getAppTheme(context),
      home: getHomeScaffold(),
    );
  }
}

/*
  README:
  - When writing modules, use the moduleInterface.dart to load the widget from children files.
    In that file, import the needed file, make a function to load the widget.
    And then use that function in other files.
    DON'T IMPORT EXTRA FILES IN FILES OTHER THAN THE moduleInterface.dart FILE!
    This rule keeps the files not cluttered with imports.
  - To test the module, load its widget straight from this main.dart file.
    Do not implement the widget straight into the application, unless you know what you're doing.
*/