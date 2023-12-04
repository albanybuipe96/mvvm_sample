import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_sample/mvvm/event.dart';
import 'package:mvvm_sample/mvvm/observer.dart';
import 'package:mvvm_sample/task/repository/task_repository.dart';
import 'package:mvvm_sample/task/screens/task_ui_state.dart';
import 'package:mvvm_sample/task/viewmodel/task_viewmodel.dart';

class TaskScreen extends StatelessWidget implements Observer {
  TaskScreen({super.key}) {
    _viewModel.subscribe(this);
  }

  final TaskViewModel _viewModel = TaskViewModel(repository: TaskRepository());
  final TaskUiState state = TaskUiState();

  // @override
  @override
  Widget build(BuildContext context) {
    log('build', name: '$runtimeType');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasker 2000'),
        actions: [
          IconButton(
            onPressed: () {
              _viewModel.createTask(
                'Title ${state.tasks.length}',
                'Description ${state.tasks.length}',
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _viewModel.loadTasks();
        },
        child: const Icon(Icons.refresh),
      ),
      body: ValueListenableBuilder(
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
    );
  }

  // @override
  @override
  void notify(Event event) {
    if (event is LoadingEvent) {
      state.isLoading = event.isLoading;
    }
    if (event is TasksLoadedEvent) {
      state.tasks = event.tasks;
    }

    if (event is TaskCreatedEvent) {
      state.addTask = event.task;
    }
  }
}
