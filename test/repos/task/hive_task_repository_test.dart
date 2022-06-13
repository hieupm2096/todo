import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/models/failure.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repos/task/hive_task_repository.dart';
import '../../fixtures/fixture_reader.dart';
import 'hive_task_repository_test.mocks.dart';

@GenerateMocks([Box<Task>])
void main() {
  late MockBox<Task> mockTaskBox;
  late HiveTaskRepository repository;

  setUp(() {
    mockTaskBox = MockBox<Task>();
    repository = HiveTaskRepository(taskBox: mockTaskBox);
  });

  // getTasks
  group('getTasks', () {
    final tTasks = (jsonDecode(fixture('tasks.json')) as List).map((e) => Task.fromJson(e)).toList();

    test(
      'should return DatabaseFailure if Box is not open',
      () async {
        when(mockTaskBox.isOpen).thenReturn(false);

        final result = await repository.getTasks();

        expect(result.failure, const DatabaseFailure());
      },
    );

    test(
      'should perform Box get values if Box is open',
      () {
        when(mockTaskBox.isOpen).thenReturn(true);
        when(mockTaskBox.values).thenReturn(tTasks);

        repository.getTasks();

        verify(mockTaskBox.values);
      },
    );

    test(
      'should return List<Task>',
      () async {
        when(mockTaskBox.isOpen).thenReturn(true);
        when(mockTaskBox.values).thenReturn(tTasks);

        final result = await repository.getTasks();

        expect(result.success, tTasks);
      },
    );

    test(
      'should return List<Task> with filtered TaskStatus parameter',
      () async {
        when(mockTaskBox.isOpen).thenReturn(true);
        when(mockTaskBox.values).thenReturn(tTasks);
        final expectedResult = tTasks.where((element) => element.status == TaskStatus.complete).toList();

        final result = await repository.getTasks(taskStatus: TaskStatus.complete);

        expect(result.success, expectedResult);
      },
    );
  });

  // createTask
  group('createTask', () {
    const tContent = 'Countless coordinates will be lost in cores like anomalies in shields';

    test(
      'should return DatabaseFailure if Box is not open',
      () async {
        when(mockTaskBox.isOpen).thenReturn(false);

        final result = await repository.getTasks();

        expect(result.failure, const DatabaseFailure());
      },
    );

    test(
      'should perform Box add task if Box is open',
      () async {
        when(mockTaskBox.isOpen).thenReturn(true);

        repository.createTask(content: tContent);

        verify(mockTaskBox.add(any));
      },
    );

    
  });
}
