import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
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

    void arrangeGetTasksSuccess() {
      when(mockTaskBox.isOpen).thenReturn(true);
      when(mockTaskBox.values).thenReturn(tTasks);
    }

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
        arrangeGetTasksSuccess();

        repository.getTasks();

        verify(mockTaskBox.values);
      },
    );

    test(
      'should return List<Task>',
      () async {
        arrangeGetTasksSuccess();

        final result = await repository.getTasks();

        expect(result.success, tTasks);
      },
    );

    test(
      'should return List<Task> with filtered TaskStatus parameter',
      () async {
        arrangeGetTasksSuccess();

        final expectedResult = tTasks.where((element) => element.status == TaskStatus.complete).toList();

        final result = await repository.getTasks(taskStatus: TaskStatus.complete);

        expect(result.success, expectedResult);
      },
    );
  });

  // saveTask
  group('createTask', () {
    final tTask = Task(
      id: '6c84fb90-12c4-11e1-840d-7b25c5ee775a',
      content: 'Do the launchdry',
      createdAt: Jiffy('2021-05-25T12:00:00.000Z').dateTime,
      updatedAt: Jiffy('2021-05-25T12:00:00.000Z').dateTime,
      status: TaskStatus.complete,
    );

    void arrangeCreateTaskSuccess() {
      when(mockTaskBox.isOpen).thenReturn(true);
      when(mockTaskBox.get(any)).thenReturn(tTask);
    }

    test(
      'should return DatabaseFailure if Box is not open',
      () async {
        when(mockTaskBox.isOpen).thenReturn(false);

        final result = await repository.getTasks();

        expect(result.failure, const DatabaseFailure());
      },
    );

    test(
      'should perform Box put task if Box is open',
      () async {
        arrangeCreateTaskSuccess();

        repository.createTask(task: tTask);

        verify(mockTaskBox.put(any, any));
      },
    );

    test(
      'should perform Box get task to verify put success',
      () async {
        arrangeCreateTaskSuccess();

        await repository.createTask(task: tTask);

        verify(mockTaskBox.get(any));
      },
    );

    test('should return DatabaseFailure if could not get back put task', () async {
      when(mockTaskBox.isOpen).thenReturn(true);
      when(mockTaskBox.get(any)).thenReturn(null);

      final result = await repository.createTask(task: tTask);

      expect(result.failure, const DatabaseFailure());
    });

    test(
      'should return Task which equal to input task',
      () async {
        arrangeCreateTaskSuccess();

        final result = await repository.createTask(task: tTask);

        expect(result.success, tTask);
      },
    );
  });
}
