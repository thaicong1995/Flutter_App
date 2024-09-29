import 'package:flutter/material.dart';

class TaskitemWigget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String date;
  final IconData trackingicon;
  final Function() onEdit; // Callback cho chỉnh sửa
  final Function() onDelete; // Callback cho xóa

  const TaskitemWigget({
    required Key key,
    required this.iconData,
    required this.title,
    required this.date,
    required this.trackingicon,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
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
              Icon(iconData, color: Colors.blue, size: 28),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(trackingicon, color: Colors.blue),
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
                  onDelete(); // Gọi callback xóa
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  onEdit(); // Gọi callback chỉnh sửa
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  onDelete(); // Gọi callback xóa
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
