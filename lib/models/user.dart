class User {
  int? id;
  String userName;
  String password;
  DateTime createdAt;

  User({
    this.id,
    required this.userName,
    required this.password,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      userName: map['userName'],
      password: map['password'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
