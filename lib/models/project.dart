import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:uuid/uuid.dart';

@entity
class Project {
  //set primary key for id
  @primaryKey
  final String id = Uuid().v4();
  final String title;
  final String description;
  final DateTime createdAt;
  //set default value for isVisible is True
  final bool isVisible = true;
  Project(this.title, this.description, this.createdAt);
}