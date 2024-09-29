class WorkTodo {
  int? id;
  String title;
  String description;
  DateTime deadline;
  bool isDone;
  DateTime createdAt;
  int? userId;

  WorkTodo({
    this.id,
    required this.title,
    required this.description,
    required this.deadline,
    this.isDone = false,
    DateTime? createdAt,
    this.userId, // Khóa phụ
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    final endOfDay = DateTime(deadline.year, deadline.month, deadline.day, 23, 59, 59);
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': endOfDay.toIso8601String(),
      'isDone': isDone ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
    };
  }

  factory WorkTodo.fromMap(Map<String, dynamic> map) {
    return WorkTodo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      deadline:  DateTime.parse(map['deadline']),
      isDone: map['isDone'] == 1,
      createdAt: DateTime.parse(map['createdAt']),
      userId: map['userId'],
    );
  }


}
