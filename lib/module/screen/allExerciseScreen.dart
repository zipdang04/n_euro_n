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

class ExerciseCard extends StatelessWidget {
  ExerciseCard({Key? key, required this.exerciseData}) : super(key: key);
  Exercise exerciseData;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Container(
          child: Text(exerciseData.getName()),
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}

List<ExerciseCard> getExerciseCardList() {
  List<ExerciseCard> _items = [];
  List<Exercise> _exercises = getExerciseList();
  for (int _i = 0; _i < _exercises.length; _i++) {
    _items.add(ExerciseCard(exerciseData: _exercises.elementAt(_i)));
  }
  return _items;
}