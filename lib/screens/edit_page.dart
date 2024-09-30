import 'package:flutter/material.dart';
import 'package:flutter_application/models/workTodo.dart';
import 'package:flutter_application/service/workService.dart';

class EditForm extends StatefulWidget {
  final Map<String, dynamic> task;
  final Function(Map<String, dynamic>) onSave;

  const EditForm({Key? key, required this.task, required this.onSave}) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String _selectedDate = '';
  bool _isDone = false;


  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task['title']);
    _descriptionController = TextEditingController(text: widget.task['description']);

    // Chuyển đổi deadline từ chuỗi sang DateTime
    if (widget.task['deadline'] != null) {
      DateTime deadline = DateTime.parse(widget.task['deadline']);
      _selectedDate = deadline.toIso8601String().split('T').first;
    }

    // Chuyển đổi giá trị isDone từ int sang bool
    _isDone = (widget.task['isDone'] ?? 0) == 1;
  }



  Future<void> _saveTask() async {
    try {
      DateTime parsedDeadline = DateTime.parse(_selectedDate);

      WorkTodo updatedTask = WorkTodo(
        id: widget.task['id'],
        title: _titleController.text,
        description: _descriptionController.text,
        deadline: parsedDeadline,
        isDone: _isDone,
        createdAt: DateTime.now(),
        userId: widget.task['userId'],
      );


      int result = await Update(updatedTask);

      if (result > 0) {
        widget.onSave(updatedTask.toMap());
        Navigator.pop(context);
      } else {
        print('Fail');
      }
    } catch (e) {
      print('E: $e');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate.toIso8601String().split('T').first;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.white60,
                ),
                child: Text(
                  _selectedDate.isEmpty ? 'Due Date' : _selectedDate,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: _saveTask,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: _isDone,
                onChanged: (value) {
                  setState(() {
                    _isDone = value!;
                  });
                },
              ),
              Text('Task is done'),
            ],
          ),
        ],
      ),
    );
  }
}
