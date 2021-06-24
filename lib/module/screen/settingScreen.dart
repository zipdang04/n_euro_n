import 'package:flutter/material.dart';
import 'package:n_euro_n/module/core/personalProgressHandler.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 100,
          child: Expanded(
            child: RaisedButton(
              onPressed: () async => await clearBoxes(),
              child: Text('Reset Database'),
            ),
          ),
        )
      ],
    );
  }
}
