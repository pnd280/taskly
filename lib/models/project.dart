import 'dart:convert';


class Project {
  //set primary key for id
  
  String id ;
  String title;
  String description;
  DateTime createdAt;
  bool isVisible ;

  Project(this.id, this.title, this.description, this.createdAt, this.isVisible);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'isVisible': isVisible,
    };}
  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      map['id'],
      map['title'],
      map['description'],
      map['createdAt'],
      map['isVisible'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Project.fromJson(String source) => Project.fromMap(json.decode(source));
  @override
  String toString() {
    return 'Project(id: $id, title: $title, description: $description, createdAt: $createdAt, isVisible: $isVisible)';
  }
}