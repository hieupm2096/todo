import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/features/app.dart';
import 'package:todo/injections.dart';
import 'package:todo/models/task.dart';
import 'package:todo/commons/constants/constants.dart' as constants;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // DI
  configureDependencies();

  // Hive
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>(constants.taskTable);

  runApp(const App());
}
