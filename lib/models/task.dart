class Task {
  int? id;
  String name;
  bool isDone;

  Task({this.id, required this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}
