import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repos/task/hive_task_repository.dart';
import 'package:todo/repos/task/task_repository.dart';
import 'package:todo/commons/constants/constants.dart' as constants;

final getIt = GetIt.instance;

void configureDependencies() {
  // Service
  getIt.registerLazySingleton<Box<Task>>(() {
    final taskBox = Hive.box<Task>(constants.taskTable);
    return taskBox;
  });

  // App
  getIt.registerLazySingleton<ITaskRepository>(
    () => HiveTaskRepository(taskBox: getIt<Box<Task>>()),
  );
}
