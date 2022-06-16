import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repos/task/task_repository.dart';
import 'package:uuid/uuid.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ITaskRepository _taskRepository;

  TaskBloc({required ITaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const TaskInitial()) {
    on<TaskFetched>(_onTaskFetched);
    on<TaskCreated>(_onTaskCreated);
    on<TaskUpdated>(_onTaskUpdated);
  }

  FutureOr<void> _onTaskFetched(
    TaskFetched event,
    Emitter<TaskState> emit,
  ) async {
    emit(const TaskFetchedInProgress());

    final result = await _taskRepository.getTasks(taskStatus: event.taskStatus);

    result.when(
      success: (tasks) => emit(TaskFetchedSuccess(tasks: tasks)),
      failure: (failure) => emit(TaskFetchedFailure(message: failure.message)),
    );
  }

  FutureOr<void> _onTaskCreated(
    TaskCreated event,
    Emitter<TaskState> emit,
  ) async {
    emit(const TaskCreatedInProgress());

    final task = Task(
      id: const Uuid().toString(),
      content: event.content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final result = await _taskRepository.createTask(task: task);

    result.when(
      success: (success) => emit(TaskCreatedSuccess(task: success)),
      failure: (failure) => emit(TaskCreatedFailure(message: failure.message)),
    );
  }

  FutureOr<void> _onTaskUpdated(TaskUpdated event, Emitter<TaskState> emit) async {
    emit(const TaskUpdatedInProgress());

    final getTaskResult = await _taskRepository.getTask(id: event.id);

    await getTaskResult.when(
      success: (task) async {
        final updatedTask = task.copyWith(
          content: event.content,
          status: event.taskStatus,
          updatedAt: DateTime.now(),
        );

        final updateTaskResult = await _taskRepository.updateTask(task: updatedTask);

        updateTaskResult.when(
          success: (success) => emit(TaskUpdatedSuccess(task: success)),
          failure: (updateTaskFailure) => emit(TaskUpdatedFailure(message: updateTaskFailure.message)),
        );
      },
      failure: (getTaskFailure) {
        emit(TaskUpdatedFailure(message: getTaskFailure.message));
      },
    );
  }
}
