import 'package:flutter/material.dart';
import 'package:apptodo/models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) toggleTask;
  final Function(Task) removeTask;

  TaskList({required this.tasks, required this.toggleTask, required this.removeTask});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(task.description),
          leading: Checkbox(
            value: task.isDone,
            onChanged: (value) {
              toggleTask(task);
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              removeTask(task);
            },
          ),
        );
      },
    );
  }
}
