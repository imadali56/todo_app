import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/dialogBox_screen.dart';
import 'package:todo_app/todo_tile.dart';

import 'data/todo_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // reference the box
  final _myBox= Hive.box('myBox');
  ToDoDatabase db= ToDoDatabase();
  @override
  void initState() {
    if(_myBox.get('ToDo')==null){
      db.createInitialeData();
    }
    else{
      db.loadData();
    }
    // TODO: implement initState
    super.initState();
  }
  final _controller= TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDo[index][1] = !db.toDo[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTasks(){
    setState(() {
      db.toDo.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }
// create new task
  createNewTask(){
    showDialog(context: context, builder: (context) {
      return DialogboxScreen(
        controller: _controller,
         onSave: saveNewTasks,
        onCancel: () => Navigator.of(context).pop()
      );
    },);
  }
  // delete task
  void deleteTask(int index){
    setState(() {
      db.toDo.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'To Do',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.black87,
        shape: CircleBorder(),
        onPressed:createNewTask,
        child: Icon(Icons.add, color: Colors.white,),
      ),
      body: ListView.builder(
        itemCount: db.toDo.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskname: db.toDo[index][0],
            taskCompleted: db.toDo[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction:(context) => deleteTask(index) ,
          );
        },
      ),
    );
  }
}
