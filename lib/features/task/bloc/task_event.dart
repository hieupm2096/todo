part of 'task_bloc.dart';

@immutable
abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class TaskFetched extends TaskEvent {
  final TaskStatus? taskStatus;

  const TaskFetched({this.taskStatus});

  @override
  List<Object?> get props => [taskStatus];
}

class TaskCreated extends TaskEvent {
  final String content;

  const TaskCreated({required this.content});

  @override
  List<Object> get props => [content];
}

class TaskUpdated extends TaskEvent {
  final String id;
  final String? content;
  final TaskStatus? taskStatus;

  const TaskUpdated({
    required this.id,
    this.content,
    this.taskStatus,
  });

  @override
  List<Object?> get props => [id, content, taskStatus];
}
