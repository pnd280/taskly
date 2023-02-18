import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskly/miscs/styles.dart';

Widget TaskCard(Map task, Color borderColor) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: const [
          TasklyStyle.shadow,
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor, width: 2),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ), // checkbox
                  Text(
                    task['title'],
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          ), // title
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.clock,
                  size: 18,
                ),
                Text(
                  TimeOfDay.fromDateTime(task['createdAt'])
                      .toString()
                      .substring(10, 15),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
