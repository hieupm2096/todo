import 'package:equatable/equatable.dart';
import 'package:jiffy/jiffy.dart';

/// id: "6c84fb90-12c4-11e1-840d-7b25c5ee775a"
/// content : "Do the launchdry"
/// status : 0
/// createdAt : "2021-05-25T12:00:00.000Z"
/// updatedAt : "2021-05-25T12:00:00.000Z"

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
  final String id;
  final String content;
  final TaskStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Task({
    required this.id,
    required this.content,
    this.status = TaskStatus.incomplete,
    this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(dynamic json) => Task(
        id: json['id'] as String,
        content: json['content'] as String,
        status: json['status'] is int ? TaskStatus.fromValue(json['status'] as int) : TaskStatus.incomplete,
        createdAt: json['createdAt'] is String ? Jiffy(json['createdAt']).dateTime : null,
        updatedAt: json['updatedAt'] is String ? Jiffy(json['updatedAt']).dateTime : null,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['content'] = content;
    map['status'] = status.value;
    map['createdAt'] = Jiffy(createdAt).utc().toIso8601String();
    map['updatedAt'] = Jiffy(updatedAt).utc().toIso8601String();
    return map;
  }

  Task copyWith({
    String? content,
    TaskStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Task(
      id: id,
      content: content ?? this.content,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, content, status, createdAt, updatedAt];
}
