import 'dart:convert';
class Tagged{
  String tagId;
  String taskId;
  Tagged(this.tagId, this.taskId);
  Map<String, dynamic> toMap() {
    return {
      'tagId': tagId,
      'taskId': taskId,
    };}
  factory Tagged.fromMap(Map<String, dynamic> map) {
    return Tagged(
      map['tagId'],
      map['taskId'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Tagged.fromJson(String source) => Tagged.fromMap(json.decode(source));
  @override
  String toString() {
    return 'Tagged(tagId: $tagId, taskId: $taskId)';
  }
}