import 'package:flutter/material.dart';
import 'package:apptodo/models/task.dart';
import 'package:apptodo/widgets/task_list.dart';

class ElementScreen extends StatefulWidget {
  final String title;
  final Color color;

  ElementScreen({required this.title, required this.color});

  @override
  _ElementScreenState createState() => _ElementScreenState();
}

class _ElementScreenState extends State<ElementScreen> {
  final List<Task> tasks = [];

  void _addTask(String taskTitle) {
    setState(() {
      tasks.add(Task(title: taskTitle));
    });
  }

  void _toggleTask(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  void _removeTask(Task task) {
    setState(() {
      tasks.remove(task);
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
