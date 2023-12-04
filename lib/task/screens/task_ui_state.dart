import 'package:flutter/foundation.dart';
import 'package:mvvm_sample/task/screens/task_ui_model.dart';

import '../models/task.dart';

class TaskUiState extends ValueNotifier<TaskUiModel> {
  TaskUiState() : super(TaskUiModel());

  bool get isLoading => value.isLoading;

  set isLoading(bool loading) {
    value.isLoading = loading;
    notifyListeners();
  }

  List<Task> get tasks => value.tasks;

  set tasks(List<Task> tasks) {
    value.tasks = tasks;
    notifyListeners();
  }

  set addTask(Task task) {
    value.tasks.add(task);
    notifyListeners();
  }
}
