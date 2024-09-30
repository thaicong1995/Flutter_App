// import 'package:flutter/material.dart';
// import 'package:flutter_application/wigget/taskitem_wigget.dart';
//
// class ListTaskWidget extends StatefulWidget {
//   final GlobalKey key;
//   final List<Map<String, dynamic>> tasks;
//
//   ListTaskWidget({required this.key, required this.tasks}) : super(key: key);
//
//   @override
//   ListTaskWidgetState createState() => ListTaskWidgetState();
// }
//
// class ListTaskWidgetState extends State<ListTaskWidget> {
//
//   List<Map<String, dynamic>> displayedTasks = [];
//
//   @override
//   void initState() {
//     super.initState();
//     displayedTasks = widget.tasks;
//   }
//
//   // Phương thức để cập nhật danh sách công việc
//   void updateTasks(List<Map<String, dynamic>> newTasks) {
//     setState(() {
//       displayedTasks = newTasks;
//     });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: widget.tasks.length,
//       itemBuilder: (context, index) {
//         // Xử lý hiển thị công việc tại đây
//         return TaskitemWidget(
//           key: ValueKey(widget.tasks[index]['id']),
//           iconData: Icons.work,
//           title: widget.tasks[index]['title'],
//           date: widget.tasks[index]['deadline'],
//           isDone: widget.tasks[index]['isDone'] == 1,
//           trackingicon: Icons.more_vert,
//           deadline: DateTime.parse(widget.tasks[index]['deadline']),
//           onEdit: () => print('Edit task ${widget.tasks[index]['id']}'),
//           onDelete: () => print('Delete task ${widget.tasks[index]['id']}'),
//         );
//       },
//     );
//   }
// }
