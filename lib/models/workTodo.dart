class WorkTodo {
  int? id; // Make sure to include this field
  String title;
  String description;
  DateTime deadline;
  bool isDone;
  DateTime createdAt;
  int userId;

  WorkTodo({
    this.id, // Include this in the constructor
    required this.title,
    required this.description,
    required this.deadline,
    required this.isDone,
    required this.createdAt,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline.toIso8601String(),
      'isDone': isDone ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
    };
  }

  static WorkTodo fromMap(Map<String, dynamic> map) {
    return WorkTodo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      deadline: DateTime.parse(map['deadline']),
      isDone: map['isDone'] == 1,
      createdAt: DateTime.parse(map['createdAt']),
      userId: map['userId'],
    );
  }
}
