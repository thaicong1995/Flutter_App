
import 'package:flutter_application/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database.dart';

// Register
Future<void> registerUser(User user) async {
  await DB.instance.insert('user_table', user.toMap());
}

// Login
Future<int?> loginUser(User user) async {
  var data = await DB.instance.findByEmail(user.userName);
  if(user.userName != data?.userName || user.password != data?.password){
    return null;
  }
  return data?.id;
}

Future<int?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId');
}