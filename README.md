# N_EURO_N - Brain Development Application

### Overview

- N_EURO_N is an application for brain development, based on various exercises. These exercises are curated to help the user improving their speed, reflex, calculation and memory ability.
- We used Flutter and Dart for development to make it future-proof. Flutter helps making native apps for various platform from a single codebase.
- N_EURO_N are developed by a team of high school students, so the exercises are designed to be suitable for everyone, especially teenagers.
- Here's some bullet points on our plan to further develop the product:
    1. More exercises, focus on quality and variety.
    2. Online tournaments to make it exciting for players, both new and experienced.

### Developed Feature

- moduleInterface.dart: A general interface to load widgets, to make it less cluttered in other files
- core/: Core files handling the basic interaction with the app
    - appTheme.dart: Contains the theme of the app, with the ability to easily create and load new ones
    - homeScaffold: Contains the scaffold structure and the tab navigation system
    - ...Handler.dart: Handles the respective aspect of the app.
- game/: Contains the developed exercises
    - gameModuleInterface.dart: Similar to moduleInterface.dart, acts as a general interface to load the exercises
    - ...Game.dart: The respective game
- screen/: Containing various screens used throughout the app

### Installation

1. Install Flutter
2. Install an IDE of your choice, we recommend Android Studio
3. Clone the repository
4. Install the pub packages with 'pub get' or with the guide in the IDE

Then you can build the app and freely tweak it.

### Integration / Fork guide

1. To add new exercises: Create a dart file in "n_euro_n\lib\module\game". Always import "package:n_euro_n/module/core/personalProgressHandler.dart".
2. When an exercise is finished, use addGameToHistory(_exerciseName, _finalScore) to add the exercise to the personal progress handler.
3. Go to "n_euro_n\lib\module\game\gameModuleInterface", import the file created, create a function to get the game with get<exercise_name>() and return the game widget.
4. Go to "n_euro_n\lib\module\core\exerciseInstance\exerciseHandler.dart" and add an item to List<Exercise> getExerciseList() like this

```dart
Exercise(
      name: '<exerciseName>',
      exerciseDestination: get<exerciseName>(),
      description: "<description>"
    ),
```

      After that, the exercise will be added to the app.

### Credit

- Idea: Nguyễn Hoàng Minh, Nguyễn Lê Bảo Nam, Đặng Xuân Minh Hiếu, Đỗ Trung Dũng.
- Core Development: Nguyễn Hoàng Minh
- Exercises: Nguyễn Hoàng Minh, Nguyễn Lê Bảo Nam, Đặng Xuân Minh Hiếu.
- UI/UX: Nguyễn Hoàng Minh, Nguyễn Lê Bảo Nam.
- R&D: Đỗ Trung Dũng
