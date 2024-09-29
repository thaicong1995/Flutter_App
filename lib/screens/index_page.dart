import 'package:flutter/material.dart';
import 'package:flutter_application/models/workTodo.dart';
import 'package:flutter_application/screens/create_form.dart';
import 'package:flutter_application/wigget/taskitem_wigget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/workService.dart';
import '../wigget/avartar_wigget.dart';
import 'login_page.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final IconData defaultIcon = Icons.work;
  final IconData trackingIcon = Icons.more_vert;
  int? userId;
  List<Map<String, dynamic>> tasks = [];



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
            onSave: (newTask)  async {
              var insertedTask = await Insert(newTask as WorkTodo);
              setState(() {
                tasks.add(insertedTask as Map<String, dynamic>);
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }


  void _editTask(int id) async{
    // await Delete(id);
  }

  void _deleteTask(int index) async {
    int idToDelete = tasks[index]['id'];

    bool isDeleted = await DeleteId(idToDelete);

    if (isDeleted) {
      setState(() {
        tasks.removeAt(index);
      });
      print("Task deleted successfully");
    } else {
      print("Task deletion failed");
    }
  }

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
                      leading: Icon(Icons.check_circle),
                      title: Text('Completed'),
                      onTap: () {
                        // Thực hiện hành động khi nhấn vào "Completed"
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.pending),
                      title: Text('Not Completed'),
                      onTap: () {
                        // Thực hiện hành động khi nhấn vào "Not Completed"
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.warning),
                      title: Text('Over Due'),
                      onTap: () {
                        // Thực hiện hành động khi nhấn vào "Over Due"
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  // Thực hiện hành động khi nhấn vào "Logout"
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskitemWigget(
                key: ValueKey(tasks[index]['id']),
                iconData: defaultIcon,
                title: tasks[index]['title'],
                date: tasks[index]['deadline'],
                trackingicon: trackingIcon,
                onEdit: () => _editTask(index), // Truyền callback chỉnh sửa
                onDelete: () => _deleteTask(index), // Truyền callback xóa
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNewTask, // Gọi hàm thêm mới khi nhấn nút
          child: Icon(Icons.add),
          tooltip: 'Thêm công việc mới',
        ),
      ),
    );
  }
}
