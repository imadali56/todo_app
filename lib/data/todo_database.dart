import 'package:hive/hive.dart';

class ToDoDatabase {
  List toDo=[];
final _myBox = Hive.box('myBox');
//run this method if app open first time
void createInitialeData(){
  toDo =[
    ['Write Your First Task!', true],

  ];
}
// load data from  database
void loadData(){
  toDo = _myBox.get('ToDo');
}
// update the database
void updateDataBase(){
  _myBox.put('ToDo', toDo);

}

}