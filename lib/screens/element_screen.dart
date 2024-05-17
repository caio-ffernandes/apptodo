import 'package:flutter/material.dart';
import 'package:apptodo/models/task.dart';
import 'package:apptodo/widgets/task_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ElementScreen extends StatefulWidget {
  final String title;
  final Color color;

  ElementScreen({required this.title, required this.color});

  @override
  _ElementScreenState createState() => _ElementScreenState();
}

class _ElementScreenState extends State<ElementScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksString = prefs.getString('tasks_${widget.title}');
    if (tasksString != null) {
      List<dynamic> taskList = jsonDecode(tasksString);
      setState(() {
        tasks = taskList.map((taskData) => Task.fromMap(taskData)).toList();
      });
    }
  }

  void _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> taskList = tasks.map((task) => task.toMap()).toList();
    prefs.setString('tasks_${widget.title}', jsonEncode(taskList));
  }

  void _addTask(String taskTitle, String taskDescription) {
    setState(() {
      tasks.add(Task(title: taskTitle, description: taskDescription));
      _saveTasks();
    });
  }

  void _toggleTask(Task task) {
    setState(() {
      task.isDone = !task.isDone;
      _saveTasks();
    });
  }

  void _removeTask(Task task) {
    setState(() {
      tasks.remove(task);
      _saveTasks();
    });
  }

  void _showAddTaskDialog() {
    String newTaskTitle = '';
    String newTaskDescription = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nova Tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Título'),
                onChanged: (value) {
                  newTaskTitle = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Descrição'),
                onChanged: (value) {
                  newTaskDescription = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Adicionar'),
              onPressed: () {
                if (newTaskTitle.isNotEmpty && newTaskDescription.isNotEmpty) {
                  _addTask(newTaskTitle, newTaskDescription);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
      body: Column(
        children: [
          Expanded(
            child: TaskList(
              tasks: tasks,
              toggleTask: _toggleTask,
              removeTask: _removeTask,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text('Adicionar Tarefa'),
                    onPressed: _showAddTaskDialog,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
