import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:uuid/uuid.dart';

@entity
class Project {
  //set primary key for id
  
  String id ;
  String title;
  String description;
  DateTime createdAt;
  //set default value for isVisible is True
  bool isVisible = true;

  Project(this.title, this.description, this.createdAt);
}