import 'package:equatable/equatable.dart';

/// id: 1
/// content : "Do the launchdry"
/// status : 0
/// createdAt : "2022-06-12T08:02:31+07:00"
/// updatedAt : "2022-06-12T08:02:31+07:00"

enum TaskStatus {
  incomplete(0),
  complete(1);

  const TaskStatus(this.value);

  final int value;

  static TaskStatus fromValue(int value) {
    return TaskStatus.values.firstWhere((element) => element.value == value);
  }
}

class Task extends Equatable {
  final int id;
  final String? content;
  final TaskStatus status;
  final String? createdAt;
  final String? updatedAt;

  const Task({
    required this.id,
    this.content,
    this.status = TaskStatus.incomplete,
    this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(dynamic json) => Task(
        id: json['id'] as int,
        content: json['content'] as String?,
        status: json['status'] is int ? TaskStatus.fromValue(json['status'] as int) : TaskStatus.incomplete,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['content'] = content;
    map['status'] = status.value;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

  @override
  List<Object?> get props => [id, content, status, createdAt, updatedAt];
}
