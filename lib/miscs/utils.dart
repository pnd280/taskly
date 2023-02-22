import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:taskly/globals.dart';

String intToWeekDay(int day) {
  switch (day) {
    case 0:
      return 'Sun';
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thu';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    default:
      return '';
  }
}

dynamic joinDateTimeAndTimeOfDay(DateTime? date, TimeOfDay? time) {
  if (date == null || time == null) {
    return null;
  }
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

String removeHtmlTags(String htmlString) {
  // Unescape HTML entities
  String unescapedString = HtmlUnescape().convert(htmlString);

  // Remove HTML tags using a regular expression
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  String cleanString = unescapedString.replaceAll(exp, '');

  return cleanString;
}

// void updateTask({required Map<String, dynamic> updatedTask}) {

//   int taskIndex =
//       placeholderTasks.indexWhere((t) => t['id'] == updatedTask['id']);
//   if (taskIndex != -1) {
//     placeholderTasks[taskIndex] = updatedTask;
//   }
// }

// void deleteTask(String taskId) {
//   placeholderTasks.removeWhere((task) => task['id'] == taskId);
// }
