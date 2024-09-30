import 'package:flutter/material.dart';

class TaskitemWidget extends StatefulWidget {
  final IconData iconData;
  final String title;
  final String date; // Ngày hoàn thành
  final IconData trackingicon;
  final Function() onEdit;
  final Function() onDelete;
  final bool isDone;
  final DateTime deadline;

  const TaskitemWidget({
    required Key key,
    required this.iconData,
    required this.title,
    required this.date,
    required this.trackingicon,
    required this.onEdit,
    required this.onDelete,
    required this.isDone,
    required this.deadline,
  }) : super(key: key);

  @override
  State<TaskitemWidget> createState() => _TaskitemWidgetState();
}

class _TaskitemWidgetState extends State<TaskitemWidget> {



  @override
  Widget build(BuildContext context) {

    Color borderColor;
    if (widget.isDone) {
      borderColor = Colors.green;
    } else if (widget.deadline.isBefore(DateTime.now())) {
      borderColor = Colors.red;
    } else {
      borderColor = Colors.transparent;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(widget.iconData, color: Colors.blue, size: 28),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.date,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(widget.trackingicon, color: Colors.blue),
            onPressed: () => _showOptions(context),
          ),
        ],
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 200,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.done),
                title: Text('Done'),
                onTap: () {
                  Navigator.pop(context);
                  widget.onEdit();
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  widget.onEdit();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  widget.onDelete();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
