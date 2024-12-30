import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool? isChecked;
  final String? taskTitle;
  final ValueChanged checkboxCallback;
  final VoidCallback? longPressCallback;
  final VoidCallback? tapCallback;

  const TaskTile(
      {super.key,
      this.isChecked,
      this.taskTitle,
      required this.checkboxCallback,
      this.longPressCallback,
      this.tapCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tapCallback,
      onLongPress: longPressCallback,
      title: Text(
        taskTitle!,
        style: TextStyle(
            decoration: isChecked! ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}
