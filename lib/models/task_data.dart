import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'task.dart';
import 'database_helper.dart';

class TaskData extends ChangeNotifier {
  final List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  int get taskCount => _tasks.length;

  int get completedTaskCount => _tasks.where((task) => task.isDone).length;

  int get notCompletedTaskCount => _tasks.where((task) => !task.isDone).length;

  Future<void> loadTasks() async {
    _tasks.clear();
    _tasks.addAll(await DatabaseHelper().getTasks());
    notifyListeners();
  }

  Future<void> addTask(String newTaskTitle) async {
    final task = Task(name: newTaskTitle, isDone: false);
    await DatabaseHelper().addTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    task.toggleDone();
    await DatabaseHelper().updateTask(task);
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    if (task.id != null) {
      await DatabaseHelper().deleteTask(task.id!);
      await loadTasks();
    }
  }

  Future<void> editTask(Task task, String updatedTaskTitle) async {
    task.name = updatedTaskTitle;
    await DatabaseHelper().updateTask(task);
    await loadTasks();
  }
}
