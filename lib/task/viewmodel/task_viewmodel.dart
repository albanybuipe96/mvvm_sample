import 'package:mvvm_sample/mvvm/event.dart';
import 'package:mvvm_sample/mvvm/viewmodel.dart';
import 'package:mvvm_sample/task/models/task.dart';
import 'package:mvvm_sample/task/repository/task_repository.dart';

class TaskViewModel extends EventViewModel {
  TaskRepository _repository;

  TaskViewModel({required TaskRepository repository})
      : _repository = repository;

  loadTasks() {
    notify(LoadingEvent(isLoading: true));
    _repository.loadTasks().then((value) {
      notify(TasksLoadedEvent(tasks: value));
      notify(LoadingEvent(isLoading: false));
    });
  }

  createTask(String title, String description) {
    notify(LoadingEvent(isLoading: true));
    final task = Task(title: title, description: description, done: false);
    _repository.addTask(task);
    notify(TaskCreatedEvent(task: task));
    notify(LoadingEvent(isLoading: false));
  }
}

class LoadingEvent extends Event {
  LoadingEvent({required this.isLoading}) : super('LoadingEvent');
  bool isLoading;
}

class TasksLoadedEvent extends Event {
  final List<Task> tasks;

  TasksLoadedEvent({required this.tasks}) : super('TasksLoadedEvent');
}

class TaskCreatedEvent extends Event {
  final Task task;

  TaskCreatedEvent({required this.task}) : super('TaskCreatedEvent');
}
