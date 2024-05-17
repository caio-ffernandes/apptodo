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
        tasks = taskList.map((taskData) => Task(
          title: taskData['title'],
          isDone: taskData['isDone']
        )).toList();
      });
    }
  }

  void _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> taskList = tasks.map((task) => {
      'title': task.title,
      'isDone': task.isDone
    }).toList();
    prefs.setString('tasks_${widget.title}', jsonEncode(taskList));
  }

  void _addTask(String taskTitle) {
    setState(() {
      tasks.add(Task(title: taskTitle));
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
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Nova Tarefa',
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _addTask(value);
                      }
                    },
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
