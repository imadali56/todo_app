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
  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_myBox.get('ToDo') == null) {
      db.createInitialeData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDo[index][2] = !db.toDo[index][2];
    });
    db.updateDataBase();
  }

  void saveNewTasks() {
    if (_titleController.text.isNotEmpty) {
      setState(() {
        db.toDo.add([_titleController.text, _descController.text, false]);
        _titleController.clear();
        _descController.clear();
      });
      Navigator.of(context).pop();
      db.updateDataBase();
    }
  }

  void editTask(int index) {
    _titleController.text = db.toDo[index][0];
    _descController.text = db.toDo[index][1];

    showDialog(
      context: context,
      builder: (context) {
        return DialogboxScreen(
          titleController: _titleController,
          descController: _descController,
          onSave: () {
            setState(() {
              db.toDo[index] = [
                _titleController.text,
                _descController.text,
                db.toDo[index][2],
              ];
              _titleController.clear();
              _descController.clear();
            });
            Navigator.of(context).pop();
            db.updateDataBase();
          },
          onCancel: () {
            _titleController.clear();
            _descController.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void createNewTask() {
    _titleController.clear();
    _descController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return DialogboxScreen(
          titleController: _titleController,
          descController: _descController,
          onSave: saveNewTasks,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
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
          'MY TO-DO',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        shape: const CircleBorder(),
        onPressed: createNewTask,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: db.toDo.isEmpty
          ? const Center(child: Text("No tasks found."))
          : ListView.builder(
              itemCount: db.toDo.length,
              itemBuilder: (context, index) {
                return TodoTile(
                  taskname: db.toDo[index][0].toString(),
                  description: db.toDo[index][1].toString(),
                  taskCompleted: db.toDo[index][2],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                  onTap: () => editTask(index),
                );
              },
            ),
    );
  }
}
