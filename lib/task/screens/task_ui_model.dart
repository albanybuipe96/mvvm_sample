
import '../models/task.dart';

class TaskUiModel {
  bool isLoading = false;
  List<Task> tasks = List.empty(growable: true);

  TaskUiModel();
}