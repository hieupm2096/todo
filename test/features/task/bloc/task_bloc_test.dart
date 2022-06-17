import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_result/simple_result.dart';
import 'package:todo/features/task/bloc/task_bloc.dart';
import 'package:todo/models/failure.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repos/task/task_repository.dart';

import '../../../fixtures/fixture_reader.dart';
import 'task_bloc_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<ITaskRepository>(as: Symbol("MockTaskRepository")),
  ],
)
void main() {
  late MockTaskRepository mockTaskRepository;
  late TaskBloc taskBloc;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    taskBloc = TaskBloc(taskRepository: mockTaskRepository);
  });

  test('initial state should be TaskInitial', () {
    expect(taskBloc.state, const TaskInitial());
  });

  // TaskFetched
  group('TaskFetched event', () {
    const tIsDone = true;
    final tTasks = (jsonDecode(fixture('tasks.json')) as List).map((e) => Task.fromJson(e)).toList();

    void arrangeTaskFetchedSuccess() {
      when(mockTaskRepository.getTasks(isDone: anyNamed("isDone")))
          .thenAnswer((_) => Future.value(Result.success(tTasks)));
    }

    void arrangeTaskFetchedFailure() {
      when(mockTaskRepository.getTasks(isDone: anyNamed("isDone")))
          .thenAnswer((_) => Future.value(const Result.failure(DatabaseFailure())));
    }

    blocTest(
      'should call ITaskRepository.getTasks with proper isDone parameter',
      build: () {
        arrangeTaskFetchedSuccess();
        return taskBloc;
      },
      act: (TaskBloc bloc) => bloc.add(const TaskFetched(isDone: tIsDone)),
      verify: (_) {
        verify(mockTaskRepository.getTasks(isDone: tIsDone)).called(1);
      },
    );

    blocTest(
      'should emit [TaskFetchedInProgress, TaskFetchedSuccess] when TaskRepository.getTasks return Result.success',
      build: () {
        arrangeTaskFetchedSuccess();
        return taskBloc;
      },
      act: (TaskBloc bloc) => bloc.add(const TaskFetched(isDone: tIsDone)),
      expect: () => [
        const TaskFetchedInProgress(),
        TaskFetchedSuccess(tasks: tTasks),
      ],
    );

    blocTest(
      'should emit [TaskFetchedInProgress, TaskFetchedFailure] when TaskRepository.getTasks return Result.failure',
      build: () {
        arrangeTaskFetchedFailure();
        return taskBloc;
      },
      act: (TaskBloc bloc) => bloc.add(const TaskFetched(isDone: tIsDone)),
      expect: () => [
        const TaskFetchedInProgress(),
        TaskFetchedFailure(message: const DatabaseFailure().message),
      ],
    );
  });

  // TaskCreated
  group('TaskCreated', () {
    const tContent = 'The dead astronaut quickly translates the pathway.';
    final tTask = Task(
      id: '6c84fb90-12c4-11e1-840d-7b25c5ee775a',
      content: tContent,
      createdAt: DateTime.parse('2021-05-25T12:00:00.000Z'),
      updatedAt: DateTime.parse('2021-05-25T12:00:00.000Z'),
    );

    blocTest(
      'should call ITaskRepository.createTask with parameter',
      build: () {
        when(mockTaskRepository.createTask(task: argThat(isNotNull, named: 'task')))
            .thenAnswer((_) => Future.value(Result.success(tTask)));
        return taskBloc;
      },
      act: (TaskBloc bloc) => bloc.add(const TaskCreated(content: tContent)),
      verify: (_) {
        verify(mockTaskRepository.createTask(task: argThat(isNotNull, named: 'task'))).called(1);
      },
    );

    blocTest(
      'should emit [TaskCreatedInProgress, TaskCreatedSuccess] when TaskRepository.createTask return Result.success',
      build: () {
        when(mockTaskRepository.createTask(task: argThat(isNotNull, named: 'task')))
            .thenAnswer((_) => Future.value(Result.success(tTask)));
        return taskBloc;
      },
      act: (TaskBloc bloc) => bloc.add(const TaskCreated(content: tContent)),
      expect: () => [
        const TaskCreatedInProgress(),
        TaskCreatedSuccess(task: tTask),
      ],
    );

    blocTest(
      'should emit [TaskCreatedInProgress, TaskCreatedFailure] when TaskRepository.createTask return Result.failure',
      build: () {
        when(mockTaskRepository.createTask(task: argThat(isNotNull, named: 'task')))
            .thenAnswer((_) => Future.value(const Result.failure(DatabaseFailure())));
        return taskBloc;
      },
      act: (TaskBloc bloc) => bloc.add(const TaskCreated(content: tContent)),
      expect: () => [
        const TaskCreatedInProgress(),
        TaskCreatedFailure(message: const DatabaseFailure().message),
      ],
    );
  });

  // TaskUpdated
  group('TaskUpdated', () {
    const tId = '6c84fb90-12c4-11e1-840d-7b25c5ee775a';
    const tContent = 'The dead astronaut quickly translates the pathway.';
    const tIsDone = true;

    final tTask = Task(
      id: tId,
      content: 'Emitters go on resistance at deep space!',
      createdAt: DateTime.parse('2021-05-25T12:00:00.000Z'),
      updatedAt: DateTime.parse('2021-05-25T12:00:00.000Z'),
    );

    void arrangeTaskUpdatedSuccess() {
      when(mockTaskRepository.getTask(id: argThat(isNotNull, named: 'id')))
          .thenAnswer((_) => Future.value(Result.success(tTask)));
      when(mockTaskRepository.updateTask(task: argThat(isNotNull, named: 'task')))
          .thenAnswer((_) => Future.value(Result.success(tTask)));
    }

    blocTest(
      'should call ITaskRepository.getTask with parameter',
      build: () {
        arrangeTaskUpdatedSuccess();
        return taskBloc;
      },
      act: (TaskBloc bloc) => bloc.add(const TaskUpdated(id: tId, content: tContent, isDone: tIsDone)),
      verify: (_) {
        verify(mockTaskRepository.getTask(id: tId)).called(1);
      },
    );

    blocTest(
      'should call ITaskRepository.updateTask with parameter',
      build: () {
        arrangeTaskUpdatedSuccess();
        return taskBloc;
      },
      act: (TaskBloc bloc) => bloc.add(const TaskUpdated(id: tId, content: tContent, isDone: tIsDone)),
      verify: (_) {
        verify(mockTaskRepository.updateTask(task: argThat(isNotNull, named: 'task'))).called(1);
      },
    );

    blocTest(
      'should emit [TaskUpdatedInProgress, TaskUpdatedSuccess] when TaskRepository.updateTask return Result.success',
      build: () {
        arrangeTaskUpdatedSuccess();
        return taskBloc;
      },
      act: (TaskBloc bloc) => bloc.add(const TaskUpdated(id: tId, content: tContent, isDone: tIsDone)),
      expect: () => [
        const TaskUpdatedInProgress(),
        TaskUpdatedSuccess(task: tTask),
      ],
    );

    blocTest(
      'should emit [TaskUpdatedInProgress, TaskUpdatedFailure] when TaskRepository.getTask return Result.failure',
      build: () {
        when(mockTaskRepository.getTask(id: argThat(isNotNull, named: 'id')))
            .thenAnswer((_) => Future.value(const Result.failure(NotFoundFailure())));
        when(mockTaskRepository.updateTask(task: argThat(isNotNull, named: 'task')))
            .thenAnswer((_) => Future.value(Result.success(tTask)));
        return taskBloc;
      },
      act: (TaskBloc bloc) => bloc.add(const TaskUpdated(id: tId, content: tContent, isDone: tIsDone)),
      expect: () => [
        const TaskUpdatedInProgress(),
        TaskUpdatedFailure(message: const NotFoundFailure().message),
      ],
    );

    blocTest(
      'should emit [TaskUpdatedInProgress, TaskUpdatedFailure] when TaskRepository.updateTask return Result.failure',
      build: () {
        when(mockTaskRepository.getTask(id: argThat(isNotNull, named: 'id')))
            .thenAnswer((_) => Future.value(Result.success(tTask)));
        when(mockTaskRepository.updateTask(task: argThat(isNotNull, named: 'task')))
            .thenAnswer((_) => Future.value(const Result.failure(DatabaseFailure())));
        return taskBloc;
      },
      act: (TaskBloc bloc) => bloc.add(const TaskUpdated(id: tId, content: tContent, isDone: tIsDone)),
      expect: () => [
        const TaskUpdatedInProgress(),
        TaskUpdatedFailure(message: const DatabaseFailure().message),
      ],
    );
  });
}
