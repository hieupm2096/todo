import 'package:simple_result/simple_result.dart';
import 'package:todo/models/failure.dart';
import 'package:todo/models/task.dart';

abstract class ITaskRepository {
  Future<Result<List<Task>, Failure>> getTasks({
    TaskStatus? taskStatus,
  });

  Future<Result<Task, Failure>> createTask({
    String? content,
  });

  Future<Result<Task, Failure>> updateTask({
    String? content,
    TaskStatus? taskStatus,
  });
}
