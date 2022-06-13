import 'package:hive/hive.dart';
import 'package:simple_result/simple_result.dart';
import 'package:todo/models/failure.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repos/task/task_repository.dart';
import 'package:todo/commons/constants/constants.dart' as constants;

class HiveTaskRepository implements ITaskRepository {
  final Box<Task> _taskBox;

  const HiveTaskRepository({required Box<Task> taskBox}) : _taskBox = taskBox;

  @override
  Future<Result<Task, Failure>> createTask({required String content}) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Task>, Failure>> getTasks({
    TaskStatus? taskStatus,
  }) async {
    if (!_taskBox.isOpen) {
      return const Result.failure(DatabaseFailure());
    }

    late List<Task> tasks;

    if (taskStatus != null) {
      tasks = _taskBox.values.where((element) => element.status == taskStatus).toList();
    } else {
      tasks = _taskBox.values.toList();
    }
    return Result.success(tasks);
  }

  @override
  Future<Result<Task, Failure>> updateTask({String? content, TaskStatus? taskStatus}) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
