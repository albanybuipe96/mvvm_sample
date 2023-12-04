# mvvm_sample

A new Flutter project.

## Getting Started

Clean state management in Flutter without the need of any 3rd party libraries.

Created using [Martin Nowosad's](https://itnext.io/mvvm-in-flutter-from-scratch-17757b6433eb) Medium article [Flutter: Clean and Simple State Management with pure MVVM](https://itnext.io/mvvm-in-flutter-from-scratch-17757b6433eb).

However, I'm not a great fan of `setState` which he used, so I rewrote parts of the code to remove all state changes made with `setState`.

I archived this with `ValueNotifier<T>` and `ValueListenableBuilder`.
Here is my Ui model, it encapsulates the state variables for the screen.
```dart
class TaskUiModel {
  bool isLoading = false;
  List<Task> tasks = List.empty(growable: true);

  TaskUiModel();
}
```
And following is the `ValueNotifier` implementation:
```dart
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
```

And here's how state changes are rendered in the UI:
```dart
ValueListenableBuilder(
    valueListenable: state,
    builder: (context, uiModel, child) {
      if (uiModel.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (uiModel.tasks.isNotEmpty) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(uiModel.tasks[index].title),
              subtitle: Text(uiModel.tasks[index].description),
            );
          },
          itemCount: uiModel.tasks.length,
        );
      }
      return const SizedBox();
    },
),
```