import 'package:intl/intl.dart';
import 'package:taskly/globals.dart';
import 'dart:developer';

List<List> filterTasks({
  required List tasks,
  required int sortType,
  bool showCompleted = false,
}) {
  if (tasks.isEmpty) {
    return [];
  }

  // log(tasks.toString());

  // tasks.sort((a, b) {
  //   if (a['beginAt'] == null && b['beginAt'] == null) {
  //     return 0;
  //   } else if (a['beginAt'] == null) {
  //     return 1;
  //   } else if (b['beginAt'] == null) {
  //     return -1;
  //   } else {
  //     return a['beginAt'].compareTo(b['beginAt']);
  //   }
  // });

  // log(tasks.toString());

  for (var task in tasks) {
    dynamic beginAt = task['beginAt'];
    if (task['beginAt'] == null) {
      beginAt = task['createdAt'];
    }
    uniqueDays.add(DateFormat('yyyy-MM-dd').format(beginAt));
  }

  var sortedDay = uniqueDays.toList()..sort((a, b) => a.compareTo(b));

  List<List> ret = [];

  for (var day in sortedDay) {
    List taskList = [];
    for (var task in tasks) {
      dynamic beginAt = task['beginAt'];
      if (task['beginAt'] == null) {
        beginAt = task['createdAt'];
      }

      var formattedBeginAt = DateFormat('yyyy-MM-dd').format(beginAt);

      if (formattedBeginAt == day) {
        if (showCompleted) {
          if (!task['isCompleted']) continue;
        } else {
          if (!task['isVisible'] || task['isCompleted']) continue;
        }
        switch (sortType) {
          case 1: // in progress
            if (DateTime.now().difference(beginAt).inDays != 0) continue;
            break;
          case 3: // todo
            // log('${task['title']} ${DateTime.now().difference(beginAt).inDays}');
            if (DateTime.now().difference(beginAt).inDays > 0) continue;
            break;
          default:
        }

        taskList.add(task);
      }
    }
    ret.add(taskList);
  }

  // log(ret.toString());

  return ret.reversed.toList();
}

List<List> filterInProgressTasks(List tasks) {
  if (tasks.isEmpty) {
    return [];
  }

  for (var task in tasks) {
    dynamic beginAt = task['beginAt'];
    if (task['beginAt'] == null) {
      beginAt = task['createdAt'];
    }
    uniqueDays.add(DateFormat('yyyy-MM-dd').format(beginAt));
  }

  var sortedDay = uniqueDays.toList()..sort((a, b) => a.compareTo(b));

  List<List> ret = [];

  for (var day in sortedDay) {
    List taskList = [];
    for (var task in tasks) {
      dynamic beginAt = task['beginAt'];
      if (task['beginAt'] == null) {
        beginAt = task['createdAt'];
      }

      var formattedBeginAt = DateFormat('yyyy-MM-dd').format(beginAt);

      if (formattedBeginAt == day) {
        // dev.log(task.toString());
        if (!task['isVisible'] || task['isCompleted']) continue;
        if (DateTime.now().difference(beginAt).inDays != 0) continue;

        taskList.add(task);
      }
    }
    ret.add(taskList);
  }

  // log(ret.toString());

  return ret.reversed.toList();
}
