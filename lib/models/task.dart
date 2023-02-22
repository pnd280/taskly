class Task {
  String id;
  String title;
  String richDescription;
  DateTime createdAt;
  DateTime beginAt;
  DateTime endAt;
  bool repeat;
  int priority;
  bool isCompleted;
  String projectId;
  bool isVisible;

  Task({
    required this.id,
    required this.title,
    required this.richDescription,
    required this.createdAt,
    required this.beginAt,
    required this.endAt,
    this.repeat = false,
    this.priority = 4,
    this.isCompleted = false,
    required this.projectId,
    this.isVisible = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'rich_description': richDescription,
      'createdAt': createdAt.toIso8601String(),
      'beginAt': beginAt.toIso8601String(),
      'endAt': endAt.toIso8601String(),
      'repeat': repeat ? 1 : 0,
      'priority': priority,
      'isCompleted': isCompleted ? 1 : 0,
      'projectId': projectId,
      'isVisible': isVisible ? 1 : 0,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      richDescription: map['rich_description'],
      createdAt: DateTime.parse(map['createdAt']),
      beginAt: DateTime.parse(map['beginAt']),
      endAt: DateTime.parse(map['endAt']),
      repeat: map['repeat'] == 1 ? true : false,
      priority: map['priority'],
      isCompleted: map['isCompleted'] == 1 ? true : false,
      projectId: map['projectId'],
      isVisible: map['isVisible'] == 1 ? true : false,
    );
  }
}
