import 'package:hive/hive.dart';

class ToDoDatabase {
  List toDo = [];

  final _myBox = Hive.box('myBox');

  void createInitialeData() {
    toDo = [
      ["Welcome Task", "Tap the plus button to add more!", false],
    ];
  }


  void loadData() {
    toDo = _myBox.get('ToDo');
  }

  void updateDataBase() {
    _myBox.put('ToDo', toDo);
  }
}