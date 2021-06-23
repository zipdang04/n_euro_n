import 'package:flutter/material.dart';

class Exercise {
  Exercise({
    required this.name,
    required this.exerciseDestination,
  });
  String name;
  Widget exerciseDestination;
  String getName() {
    return name;
  }
  Widget getDestination() {
    return exerciseDestination;
  }
}

List<Exercise> getExerciseList() {
  List<Exercise> _items = [];
  _items.add(Exercise(name: 'Example Exercise', exerciseDestination: Container()));
  return _items;
}