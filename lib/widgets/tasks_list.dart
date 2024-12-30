import 'package:flutter/material.dart';
import 'package:todoey/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/models/task.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              checkboxCallback: (checkboxState) {
                taskData.updateTask(task);
              },
              tapCallback: () {
                if (!task.isDone) {
                  _showEditTaskDialog(context, task, taskData);
                }
              },
              longPressCallback: () {
                taskData.deleteTask(task);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${task.name} deleted')),
                );
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }

  void _showEditTaskDialog(BuildContext context, Task task, TaskData taskData) {
    String? updatedTaskTitle = task.name;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            autofocus: true,
            controller: TextEditingController(text: task.name),
            onChanged: (value) {
              updatedTaskTitle = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (updatedTaskTitle != null &&
                    updatedTaskTitle!.trim().isNotEmpty) {
                  taskData.editTask(task, updatedTaskTitle!);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
