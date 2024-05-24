  import 'package:hive/hive.dart';
import 'package:apptodo/models/task.dart'; // Importe a classe Task ou o caminho correto para ela

class TaskHive {
  static const _boxName = 'tasks';

  static Future<void> init() async {
    await Hive.openBox<Task>(_boxName);
  }

  static Future<Box<Task>> openBox() async {
    return await Hive.openBox<Task>(_boxName);
  }

  static Future<void> addTask(Task task) async {
    final box = await openBox();
    await box.add(task);
  }

  static Future<List<Task>> loadTasks() async {
    final box = await openBox();
    return box.values.toList();
  }
}
