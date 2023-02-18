import 'dart:math';

import 'package:flutter/material.dart';

DateTime generateRandomTime() {
  final random = Random();
  final now = DateTime.now();

  final hours =
      random.nextInt(11) - 5; // Generates a random number between -5 and 5
  final time = now.add(Duration(hours: hours));
  return time;
}

final List<Map<String, dynamic>> dummyTasks = [
  {
    'id': 1,
    'title': 'Complete math assignment',
    'rich_description': 'Finish the calculus problem set by Friday',
    'createdAt': generateRandomTime(),
    'beginAt': null,
    'endAt': DateTime(2023, 02, 25, 17, 0),
    'repeat': false,
    'priority': 2,
    'isCompleted': false,
    'projectId': 'school',
    'isVisible': true,
  },
  {
    'id': 2,
    'title': 'Go for a run',
    'rich_description': 'Jog for 30 minutes around the park',
    'createdAt': generateRandomTime(),
    'beginAt': null,
    'endAt': null,
    'repeat': true,
    'priority': 3,
    'isCompleted': false,
    'projectId': 'personal',
    'isVisible': true,
  },
  {
    'id': 3,
    'title': 'Buy a birthday present',
    'rich_description': 'Purchase a gift for my friend\'s birthday',
    'createdAt': generateRandomTime(),
    'beginAt': null,
    'endAt': DateTime(2023, 02, 19, 20, 0),
    'repeat': false,
    'priority': 1,
    'isCompleted': false,
    'projectId': 'personal',
    'isVisible': true,
  },
  {
    'id': 4,
    'title': 'Schedule dentist appointment',
    'rich_description': 'Book a check-up with my dentist',
    'createdAt': generateRandomTime(),
    'beginAt': null,
    'endAt': null,
    'repeat': false,
    'priority': 4,
    'isCompleted': false,
    'projectId': 'health',
    'isVisible': true,
  },
  {
    'id': 5,
    'title': 'Submit project proposal',
    'rich_description': 'Send the project proposal to the client',
    'createdAt': generateRandomTime(),
    'beginAt': null,
    'endAt': DateTime(2023, 02, 22, 14, 0),
    'repeat': false,
    'priority': 5,
    'isCompleted': false,
    'projectId': 'work',
    'isVisible': true,
  },
];

final List dummyTags = [
  'All',
  'In Progress',
  'Completed',
  'Todo',
];
final List<String> dummyUserTags = <String>[
  'Custom tags',
  'Personal',
  'Work',
  'Shopping'
];
