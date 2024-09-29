import 'package:flutter/material.dart';
import '../models/workTodo.dart';
import '../database/database.dart';
import '../service/userService.dart';
import '../service/workService.dart'; // Đảm bảo import đúng database

class CreateForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  CreateForm({required this.onSave});

  @override
  _CreateFormState createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedDate = "";

  Future<WorkTodo?> _saveTask() async {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _selectedDate.isNotEmpty) {

      DateTime deadline = DateTime.parse(_selectedDate);

      WorkTodo newTask = WorkTodo(
        title: _titleController.text,
        description: _descriptionController.text,
        deadline: deadline,
        isDone: false,
        createdAt: DateTime.now(),
        userId: await getUserId(),
      );

      var resualt = await Insert(newTask);

      if (resualt != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sucess!'),
            backgroundColor: Colors.green,),

        );
        Navigator.pop(context);
        print(resualt);
        return resualt;
      }

      return null;
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
    );
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
            decoration: _inputDecoration('Title'),
            obscureText: false,
          ),
          SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: _inputDecoration('Description'),
            obscureText: false,
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
                      _selectedDate = pickedDate.toIso8601String().split('T').first; ;
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
        ],
      ),
    );
  }
}
