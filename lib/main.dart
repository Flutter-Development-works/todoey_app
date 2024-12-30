import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/task_data.dart';
// import 'screens/tasks_screen.dart';
// import 'screens/signin.dart';
import 'screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final taskData = TaskData();
  await taskData.loadTasks();
  runApp(
    ChangeNotifierProvider(
      create: (context) => taskData,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todoey',
      theme: ThemeData.light(),
      home: SignUpPage(),
    );
  }
}
