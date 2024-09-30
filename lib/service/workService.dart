import 'package:flutter_application/service/userService.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database.dart';
import '../models/workTodo.dart';

Future<int?> Insert(WorkTodo worktodo) async {
  var userId = await getUserId();

  if (userId == null) {
    return Future.error('User ID is null');
  }

  WorkTodo newWorkTodo = WorkTodo(
    title: worktodo.title,
    description: worktodo.description,
    deadline: worktodo.deadline,
    isDone: false,
    createdAt: DateTime.now(),
    userId: userId,
  );

  int id = await DB.instance.insert('todo_table', newWorkTodo.toMap());

  newWorkTodo.id = id;
  print('Inserted Task ID: $id');
  return id;
}



Future<int> Update(WorkTodo worktodo) async {
  final db = await DB.instance.data;
  Map<String, dynamic> row = {
    'title': worktodo.title,
    'description': worktodo.description,
    'deadline': worktodo.deadline.toIso8601String(),
    'isDone': worktodo.isDone ? 1 : 0,
    'createdAt': worktodo.createdAt.toIso8601String(),
    'userId': worktodo.userId,
  };

  int result = await db.update(
    'todo_table',
    row,
    where: 'id = ?',
    whereArgs: [worktodo.id],
  );

  return result;
}

Future<List<Map<String, dynamic>>> GetAll () async{
 return await DB.instance.getAll("todo_table");
}

Future<bool> DeleteId(int id) async{
  await DB.instance.delete("todo_table", id);
  return true;
}