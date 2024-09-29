import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final String description;
  final String deadline;
  final bool isDone;

  const TodoItem({
    required this.title,
    required this.description,
    required this.deadline,
    required this.isDone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isDone,
        onChanged: (bool? value) {
          // Thêm hành động khi checkbox được nhấn
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          decoration: isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description),
          Text('Hạn: $deadline'),
        ],
      ),
    );
  }
}
