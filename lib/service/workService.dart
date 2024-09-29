import 'package:flutter_application/service/userService.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database.dart';
import '../models/workTodo.dart';

Future<WorkTodo> Insert(WorkTodo worktodo) async {
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
  return newWorkTodo;
}

Future<List<Map<String, dynamic>>> GetAll () async{
 return await DB.instance.getAll("todo_table");
}

Future<bool> DeleteId(int id) async{
  await DB.instance.delete("todo_table", id);
  return true;
}