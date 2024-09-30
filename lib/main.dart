import 'package:flutter/material.dart';
import 'package:flutter_application/screens/wellcome_page.dart';

import 'database/database.dart';
import 'models/workTodo.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  // List<WorkTodo> tasks = [
  //   WorkTodo(id: 0, title: 'thai', description: '123', deadline: DateTime.parse('2024-09-30T00:00:00.000'), isDone: false, createdAt: DateTime.now(), userId: 1),
  //   WorkTodo(id: 0, title: '123', description: '123', deadline: DateTime.parse('2024-09-30T00:00:00.000'), isDone: false, createdAt: DateTime.now(), userId: 1),
  //   WorkTodo(id: 0, title: 'thai', description: '123', deadline: DateTime.parse('2024-09-30T00:00:00.000'), isDone: false, createdAt: DateTime.now(), userId: 1),
  //   WorkTodo(id: 0, title: 'thaiiii', description: '12`12', deadline: DateTime.parse('2024-09-30T00:00:00.000'), isDone: false, createdAt: DateTime.now(), userId: 1),
  //   WorkTodo(id: 0, title: 'llllllll', description: 'lllll', deadline: DateTime.parse('2024-09-30T00:00:00.000'), isDone: false, createdAt: DateTime.now(), userId: 1),
  //   WorkTodo(id: 0, title: 'jjjjjjj', description: '1111111', deadline: DateTime.parse('2024-09-30T00:00:00.000'), isDone: false, createdAt: DateTime.now(), userId: 1),
  //   WorkTodo(id: 0, title: 'ooooooooo', description: '00000', deadline: DateTime.parse('2024-09-30T00:00:00.000'), isDone: false, createdAt: DateTime.now(), userId: 1),
  //   WorkTodo(id: 0, title: 'pppppp', description: 'ppppp', deadline: DateTime.parse('2024-09-21T00:00:00.000'), isDone: false, createdAt: DateTime.now(), userId: 1),
  //   WorkTodo(id: 0, title: 'pppppp', description: 'ppppp', deadline: DateTime.parse('2024-09-21T00:00:00.000'), isDone: false, createdAt: DateTime.now(), userId: 1),
  // ];
  //
  // tasks.forEach((task) => print(task.toMap()));
  // tasks.removeWhere((WorkTodo task) => !task.isDone);


  final database = DB.instance;
  // // await database.deleteDatabase();
  //
  await database.data;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WellcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
