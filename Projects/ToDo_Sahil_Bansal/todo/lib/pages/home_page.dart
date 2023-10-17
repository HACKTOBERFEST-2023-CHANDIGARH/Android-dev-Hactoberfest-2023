import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import 'package:todo/utils.dart/dialog_box.dart';
import 'package:todo/utils.dart/todo_tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _myBox = Hive.box('mybox');

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {

    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    } else{
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });

    db.updateDataBase();
  }

    void saveNewTask(){
      setState(() {
      db.todoList.add([_controller.text, false]);
      });
      Navigator.pop(context);
      _controller.clear();
      db.updateDataBase();
    }


  void createNewTask(){
    showDialog(context: context, builder: (context){
      return MyDialogBox(
        controller: _controller,
        onCancel: () => Navigator.of(context).pop(),
        onSave: saveNewTask,
      );
    });
  }

  void deleteTask(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text("TO DO"),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTiles(
            taskName: db.todoList[index][0],
            taskCompeleted: db.todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction:(context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
