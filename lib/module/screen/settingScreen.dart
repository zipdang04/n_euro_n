import 'package:flutter/material.dart';

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
              onPressed: () {},
              child: Text('Reset Database'),
            ),
          ),
        )
      ],
    );
  }
}
