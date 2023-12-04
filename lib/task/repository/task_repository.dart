import 'package:mvvm_sample/task/models/task.dart';

class TaskRepository {
  final List<Task> _tasks = [
    Task(
      id: 0,
      title: 'Study MVVM',
      description: 'In order to avoid ugly state management libraries and '
          'collect continuous technical debt, '
          'I should study proper state management patterns',
      done: false,
    )
  ];

  addTask(Task task) {
    task.id = _tasks.length;
    _tasks.add(task);
  }

  removeTask(Task task) {
    _tasks.remove(task);
  }

  updateTask(Task task) {
    _tasks[_tasks.indexWhere((el) => el.id == task.id)] = task;
  }

  Future<List<Task>> loadTasks() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return Future.value(_tasks.toSet().toList());
  }
}
