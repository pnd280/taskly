
import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:uuid/uuid.dart';

class Tag {
  //set primary key for id
  @primaryKey
  final String id = Uuid().v4();
  final String title;
  final String color;
  //set default value for isVisible is True
  final bool isVisible = true;
  Tag(this.title, this.color);
}