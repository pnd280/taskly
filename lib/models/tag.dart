
import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:uuid/uuid.dart';

class Tag {
  String id;
  String title;
  String color;
  bool isVisible = true;

  Tag(this.title, this.color);
}