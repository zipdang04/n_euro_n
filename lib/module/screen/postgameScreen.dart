import 'package:flutter/material.dart';

class PostGameScreen extends StatelessWidget {
  PostGameScreen({Key? key, required this.playerScore}) : super(key: key);
  int playerScore = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Center(
            child: GestureDetector(
              child: Text(playerScore.toString(), style: Theme.of(context).textTheme.headline2,),
              onTap: () {
                Navigator.pop(context);
                //Navigator.pop(context);
                //Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
