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

        expect(result.success, isA<List<Task>>());
      },
    );

    test(
      'should return List<Task> with filtered TaskStatus parameter',
      () async {
        arrangeGetTasksSuccess();

        final expectedResult = tTasks.where((element) => element.isDone == true).toList();

        final result = await repository.getTasks(isDone: true);

        expect(result.success, expectedResult);
      },
    );
  });

  group('getTask', () {
    const tId = '6c84fb90-12c4-11e1-840d-7b25c5ee775a';
    final tTask = Task(
      id: tId,
      content: 'Do the launchdry',
      createdAt: DateTime.parse('2021-05-25T12:00:00.000Z'),
      updatedAt: DateTime.parse('2021-05-25T12:00:00.000Z'),
      isDone: true,
    );

    void arrangeGetTasksSuccess() {
      when(mockTaskBox.isOpen).thenReturn(true);
      when(mockTaskBox.get(any)).thenReturn(tTask);
    }

    test(
      'should return DatabaseFailure if Box is not open',
      () async {
        when(mockTaskBox.isOpen).thenReturn(false);

        final result = await repository.getTask(id: tId);

        expect(result.failure, const DatabaseFailure());
      },
    );

    test(
      'should perform Box get(id) if Box is open',
      () {
        arrangeGetTasksSuccess();

        repository.getTask(id: tId);

        verify(mockTaskBox.get(tId));
      },
    );

    test(
      'should return Task',
      () async {
        arrangeGetTasksSuccess();

        final result = await repository.getTask(id: tId);

        expect(result.success, isA<Task>());
      },
    );

    test(
      'should return Task with the same id with parameter',
      () async {
        arrangeGetTasksSuccess();

        final result = await repository.getTask(id: tId);

        expect(result.success?.id, tId);
      },
    );
  });

  // createTask
  group('createTask', () {
    final tTask = Task(
      id: '6c84fb90-12c4-11e1-840d-7b25c5ee775a',
      content: 'Do the launchdry',
      createdAt: DateTime.parse('2021-05-25T12:00:00.000Z'),
      updatedAt: DateTime.parse('2021-05-25T12:00:00.000Z'),
      isDone: true,
    );

    void arrangeSaveTaskSuccess() {
      when(mockTaskBox.isOpen).thenReturn(true);
      when(mockTaskBox.get(any)).thenReturn(tTask);
    }

    test(
      'should call saveTask',
      () {
        arrangeSaveTaskSuccess();

        repository.createTask(task: tTask);

        verify(repository.saveTask(task: tTask));
      },
    );
  });

  group('updateTask', () {
    final tTask = Task(
      id: '6c84fb90-12c4-11e1-840d-7b25c5ee775a',
      content: 'Do the launchdry',
      createdAt: DateTime.parse('2021-05-25T12:00:00.000Z'),
      updatedAt: DateTime.parse('2021-05-25T12:00:00.000Z'),
      isDone: true,
    );

    void arrangeSaveTaskSuccess() {
      when(mockTaskBox.isOpen).thenReturn(true);
      when(mockTaskBox.get(any)).thenReturn(tTask);
    }

    test(
      'should call saveTask',
      () {
        arrangeSaveTaskSuccess();

        repository.updateTask(task: tTask);

        verify(repository.saveTask(task: tTask));
      },
    );
  });

  // saveTask
  group('saveTask', () {
    final tTask = Task(
      id: '6c84fb90-12c4-11e1-840d-7b25c5ee775a',
      content: 'Do the launchdry',
      createdAt: DateTime.parse('2021-05-25T12:00:00.000Z'),
      updatedAt: DateTime.parse('2021-05-25T12:00:00.000Z'),
      isDone: true,
    );

    void arrangeSaveTaskSuccess() {
      when(mockTaskBox.isOpen).thenReturn(true);
      when(mockTaskBox.get(any)).thenReturn(tTask);
    }

    test(
      'should return DatabaseFailure if Box is not open',
      () async {
        when(mockTaskBox.isOpen).thenReturn(false);

        final result = await repository.saveTask(task: tTask);

        expect(result.failure, const DatabaseFailure());
      },
    );

    test(
      'should perform Box put task if Box is open',
      () async {
        arrangeSaveTaskSuccess();

        repository.saveTask(task: tTask);

        verify(mockTaskBox.put(any, any));
      },
    );

    test(
      'should perform Box get task to verify put success',
      () async {
        arrangeSaveTaskSuccess();

        await repository.saveTask(task: tTask);

        verify(mockTaskBox.get(any));
      },
    );

    test('should return DatabaseFailure if could not get back put task', () async {
      when(mockTaskBox.isOpen).thenReturn(true);
      when(mockTaskBox.get(any)).thenReturn(null);

      final result = await repository.saveTask(task: tTask);

      expect(result.failure, const DatabaseFailure());
    });

    test(
      'should return Task which equal to input task',
      () async {
        arrangeSaveTaskSuccess();

        final result = await repository.createTask(task: tTask);

        expect(result.success, tTask);
      },
    );
  });
}
