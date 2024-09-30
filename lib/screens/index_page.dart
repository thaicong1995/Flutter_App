import 'package:flutter/material.dart';
import 'package:flutter_application/screens/create_form.dart';
import 'package:flutter_application/wigget/taskitem_wigget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/userService.dart';
import '../service/workService.dart';
import '../wigget/avartar_wigget.dart';
import '../wigget/list_wigget.dart';
import 'edit_page.dart';
import 'login_page.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}
enum TaskFilter { all, completed, notCompleted, overdue }

class _TodoPageState extends State<TodoPage> {
  final IconData defaultIcon = Icons.work;
  final IconData trackingIcon = Icons.more_vert;
  int? userId;
  List<Map<String, dynamic>> tasks = [];

  final GlobalKey<ListTaskWidgetState> taskKey = GlobalKey<ListTaskWidgetState>();
  TaskFilter _currentFilter = TaskFilter.all;
  @override
  void initState() {
    super.initState();
    _checkUserId();
    _getAllTask();
  }

  void _getAllTask() async {
    final allTasks = await GetAll();
    setState(() {
      tasks = List<Map<String, dynamic>>.from(allTasks);
      print(tasks);
    });
  }

  void _addNewTask() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CreateForm(
            onSave: (newTask) async {
              setState(() {
                tasks.add(newTask);
              });
            },
          ),
        );
      },
    );
  }

  // void _editTask(int index) async {
  //   final taskToEdit = tasks[index];
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (context) {
  //       return Padding(
  //         padding: EdgeInsets.only(
  //           bottom: MediaQuery.of(context).viewInsets.bottom,
  //         ),
  //         child: EditForm(
  //           task: taskToEdit,
  //           onSave: (updatedTask) {
  //             setState(() {
  //               tasks[index] = updatedTask;
  //             });
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // void _deleteTask(int index) async {
  //   int idToDelete = tasks[index]['id'];
  //
  //   bool isDeleted = await DeleteId(idToDelete);
  //
  //   if (isDeleted) {
  //     setState(() {
  //       tasks.removeAt(index);
  //     });
  //     print("Task deleted successfully");
  //   } else {
  //     print("Task deletion failed");
  //   }
  // }

  Future<void> _checkUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userId')) {
      setState(() {
        userId = prefs.getInt('userId');
        print("userId${userId}");
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  void _logout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await logoutUser();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> _filterTasks() {
    DateTime now = DateTime.now();

    if (_currentFilter == TaskFilter.completed) {
      return tasks.where((task) => task['isDone'] == 1).toList();
    } else if (_currentFilter == TaskFilter.overdue) {
      return tasks.where((task) => task['isDone'] == 0 && DateTime.parse(task['deadline']).isBefore(now)).toList();
    } else if (_currentFilter == TaskFilter.notCompleted) {
      return tasks.where((task) => task['isDone'] == 0 && DateTime.parse(task['deadline']).isAfter(now)).toList();
    } else {
      return tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: media.width * 0.5,
            child: Text(
              "To do list",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          elevation: 5.0,
          shadowColor: Colors.black,
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: AvartarWigget(
                        avatarImg: "assets/image/hinh-nen-la-cay-xanh-tuoi-4k_013424501.jpg",
                        email: "thai",
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.home, color: Colors.blue),
                      title: Text('Home'),
                      onTap: () {
                        setState(() {
                          _currentFilter = TaskFilter.all;  // Cập nhật bộ lọc
                        });
                        Navigator.pop(context);  // Đóng menu
                      },
                    ),

                    ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      title: Text('Completed'),
                      onTap: () {
                        setState(() {
                          _currentFilter = TaskFilter.completed;  // Cập nhật bộ lọc
                        });
                        Navigator.pop(context);  // Đóng menu
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.pending, color: Colors.amber),
                      title: Text('Not Completed'),
                      onTap: () {
                        setState(() {
                          _currentFilter = TaskFilter.notCompleted;  // Cập nhật bộ lọc
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.warning, color: Colors.red),
                      title: Text('Over Due'),
                      onTap: () {
                        setState(() {
                          _currentFilter = TaskFilter.overdue;  // Cập nhật bộ lọc
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: _logout,
              ),
            ],
          ),
        ),
        body: ListTaskWidget(
          key: taskKey,
          tasks: _filterTasks(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNewTask,
          child: Icon(Icons.add),
          tooltip: 'Thêm công việc mới',
        ),
      ),
    );
  }
}
