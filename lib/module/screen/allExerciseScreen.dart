import 'package:flutter/material.dart';
import 'package:n_euro_n/module/core/exerciseHandler.dart';

class AllExerciseScreen extends StatelessWidget {
  AllExerciseScreen({Key? key}) : super(key: key);
  List<ExerciseCard> _items = [];
  @override
  Widget build(BuildContext context) {
    _items = getExerciseCardList();
    return Container(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int _index) {
            return _items.elementAt(_index);
          }
      ),
    );
  }
}