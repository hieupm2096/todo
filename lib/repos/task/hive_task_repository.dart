import 'package:hive/hive.dart';
import 'package:simple_result/simple_result.dart';
import 'package:todo/models/failure.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repos/task/task_repository.dart';

class HiveTaskRepository implements ITaskRepository {
  final Box<Task> _taskBox;

  const HiveTaskRepository({required Box<Task> taskBox}) : _taskBox = taskBox;

  @override
  Future<Result<Task, Failure>> createTask({required Task task}) async {
    return await _saveTask(task);
  }

  @override
  Future<Result<Task, Failure>> updateTask({required Task task}) async {
    return await _saveTask(task);
  }

  Future<Result<Task, Failure>> _saveTask(Task task) async {
    if (!_taskBox.isOpen) {
      return const Result.failure(DatabaseFailure());
    }

    await _taskBox.put(task.id, task);

    final result = _taskBox.get(task.id);

    if (result == null) {
      return const Result.failure(DatabaseFailure());
    }

    return Result.success(result);
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
}
