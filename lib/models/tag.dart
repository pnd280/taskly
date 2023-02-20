
import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:uuid/uuid.dart';

class Tag {
  String id;
  String title;
  String color;
  bool isVisible = true;

  Tag(this.id, this.title, this.color, this.isVisible);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'color': color,
      'isVisible': isVisible,
    };
  }
  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      map['id'],
      map['title'],
      map['color'],
      map['isVisible'],
    );
  }
}
