import 'package:flutter/material.dart';
import 'package:flutter_application/wigget/taskitem_wigget.dart';

import '../screens/edit_page.dart';
import '../service/workService.dart';

class ListTaskWidget extends StatefulWidget {
  final GlobalKey key;
  final List<Map<String, dynamic>> tasks;

  ListTaskWidget({required this.key, required this.tasks}) : super(key: key);

  @override
  ListTaskWidgetState createState() => ListTaskWidgetState();
}

class ListTaskWidgetState extends State<ListTaskWidget> {

  List<Map<String, dynamic>> displayedTasks = [];

  @override
  void initState() {
    super.initState();
    displayedTasks = widget.tasks;
  }

  void _editTask(int index) async {
    final taskToEdit = widget.tasks[index];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: EditForm(
            task: taskToEdit,
            onSave: (updatedTask) {
              setState(() {
                widget.tasks[index] = updatedTask;
              });
            },
          ),
        );
      },
    );
  }

  void _deleteTask(int index) async {
    int idToDelete = widget.tasks[index]['id'];

    bool isDeleted = await DeleteId(idToDelete);

    if (isDeleted) {
      setState(() {
        widget.tasks.removeAt(index);
      });
      print("Task deleted successfully");
    } else {
      print("Task deletion failed");
    }
  }


  void updateTasks(List<Map<String, dynamic>> newTasks) {
    setState(() {
      displayedTasks = newTasks;
    });
  }

    @override
    Widget build(BuildContext context) {
      return ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return TaskitemWidget(
            key: ValueKey(widget.tasks[index]['id']),
            iconData: Icons.work,
            title: widget.tasks[index]['title'],
            date: widget.tasks[index]['deadline'],
            isDone: widget.tasks[index]['isDone'] == 1,
            trackingicon: Icons.more_vert,
            deadline: DateTime.parse(widget.tasks[index]['deadline']),
            onEdit: () => _editTask(index),
            onDelete: () => _deleteTask(index),
          );
        },
      );
    }
  }

