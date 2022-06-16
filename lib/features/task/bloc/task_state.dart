part of 'task_bloc.dart';

@immutable
abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  const TaskInitial();

  @override
  List<Object> get props => [];
}

// TaskFetched
class TaskFetchedInProgress extends TaskState {
  const TaskFetchedInProgress();

  @override
  List<Object> get props => [];
}

class TaskFetchedSuccess extends TaskState {
  final List<Task> tasks;

  const TaskFetchedSuccess({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskFetchedFailure extends TaskState {
  final String? message;

  const TaskFetchedFailure({this.message});

  @override
  List<Object?> get props => [message];
}

// TaskCreated
class TaskCreatedInProgress extends TaskState {
  const TaskCreatedInProgress();

  @override
  List<Object> get props => [];
}

class TaskCreatedSuccess extends TaskState {
  final Task task;

  const TaskCreatedSuccess({required this.task});

  @override
  List<Object> get props => [task];
}

class TaskCreatedFailure extends TaskState {
  final String? message;

  const TaskCreatedFailure({this.message});

  @override
  List<Object?> get props => [message];
}

// TaskUpdated
class TaskUpdatedInProgress extends TaskState {
  const TaskUpdatedInProgress();

  @override
  List<Object> get props => [];
}

class TaskUpdatedSuccess extends TaskState {
  final Task task;

  const TaskUpdatedSuccess({required this.task});

  @override
  List<Object> get props => [task];
}

class TaskUpdatedFailure extends TaskState {
  final String? message;

  const TaskUpdatedFailure({this.message});

  @override
  List<Object?> get props => [message];
}
