part of 'task_bloc.dart';

@immutable
abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class TaskFetched extends TaskEvent {
  final bool? isDone;

  const TaskFetched({this.isDone});

  @override
  List<Object?> get props => [isDone];
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
  final bool? isDone;

  const TaskUpdated({
    required this.id,
    this.content,
    this.isDone,
  });

  @override
  List<Object?> get props => [id, content, isDone];
}
