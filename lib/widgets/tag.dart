import 'package:flutter/material.dart';

Widget Tag(String title, Color primaryColor, int index, setState, [bool isSelected = false]) {
  return InkWell(
    borderRadius: BorderRadius.circular(11),
    onTap: () {
      setState(index);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: isSelected ? primaryColor : Colors.grey.withOpacity(.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: isSelected
                ? const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )
                : TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
          ),
        ),
      ),
    ),
  );
}
