import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todo/models/task.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  final tTask = Task(
    id: '6c84fb90-12c4-11e1-840d-7b25c5ee775a',
    content: 'Do the launchdry',
    createdAt: Jiffy('2021-05-25T12:00:00.000Z').dateTime,
    updatedAt: Jiffy('2021-05-25T12:00:00.000Z').dateTime,
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
          "id": "6c84fb90-12c4-11e1-840d-7b25c5ee775a",
          "content": "Do the launchdry",
          "status": 1,
          "createdAt": "2021-05-25T12:00:00.000Z",
          "updatedAt": "2021-05-25T12:00:00.000Z"
        };
        expect(result, expectedResult);
      },
    );
  });
}
