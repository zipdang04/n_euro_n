import 'package:flutter/material.dart';
import 'package:n_euro_n/module/moduleInterface.dart';
import 'package:n_euro_n/module/game/gameModuleInterface.dart';

class Exercise {
  Exercise({
    required this.name,
    required this.exerciseDestination,
    this.description = '',
  });
  String name;
  Widget exerciseDestination;
  String description;
  String getName() {
    return name;
  }
  String getDescription() {
    return description;
  }
  Widget getDestination() {
    return exerciseDestination;
  }
}

class ExerciseCard extends StatelessWidget {
  ExerciseCard({Key? key, required this.exerciseData}) : super(key: key);
  Exercise exerciseData;
  Exercise getExerciseData() {
    return exerciseData;
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => getPreGameScreen(getExerciseData())),
            );
          },
          child: Container(
            child: Text(exerciseData.getName()),
            padding: EdgeInsets.all(8),
          ),
        ),
      ),
    );
  }
}

List<Exercise> getExerciseList() {
  List<Exercise> _items = [];
  _items.add(
    Exercise(
      name: 'Number Type Speed',
      exerciseDestination: getGameNumberTypeSpeed(),
      description: "Type as fast as possible"
    )
  );
  _items.add(
    Exercise(
      name: 'Quick Math', //two plus two is four, minus one it's three quick math!
      exerciseDestination: getQuickMath(),
      description: "Calculate as possible"
    ),
  );
  return _items;
}

List<ExerciseCard> getExerciseCardList() {
  List<ExerciseCard> _items = [];
  List<Exercise> _exercises = getExerciseList();
  for (int _i = 0; _i < _exercises.length; _i++) {
    _items.add(ExerciseCard(exerciseData: _exercises.elementAt(_i)));
  }
  return _items;
}
