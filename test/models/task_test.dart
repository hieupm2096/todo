import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo/models/task.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  const tTask = Task(
    id: 1,
    content: 'Do the launchdry',
    createdAt: '2022-06-12T08:02:31+07:00',
    updatedAt: '2022-06-12T08:02:31+07:00',
    status: TaskStatus.complete,
  );

  group('fromJson', () {
    test(
      'should return a valid Task, also validate equatable comparison',
      () async {
        final Map<String, dynamic> json = jsonDecode(fixture('task.json'));

        final result = Task.fromJson(json);

        expect(result, tTask);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map from Task object',
      () {
        final result = tTask.toJson();
        final expectedResult = {
          "id": 1,
          "content": "Do the launchdry",
          "status": 1,
          "createdAt": "2022-06-12T08:02:31+07:00",
          "updatedAt": "2022-06-12T08:02:31+07:00"
        };
        expect(result, expectedResult);
      },
    );
  });
}
