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
}