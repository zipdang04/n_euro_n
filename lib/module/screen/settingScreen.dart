import 'package:flutter/material.dart';
import 'package:n_euro_n/module/core/personalProgressHandler.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Container(
          height: 100,
          child: Expanded(
            child: ElevatedButton(
              onPressed: () async => await clearBoxes(),
              child: Text('Reset Database', style: Theme.of(context).textTheme.headline4,),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).errorColor),
              ),
            ),
          ),
        )
      ],
    );
  }
}
