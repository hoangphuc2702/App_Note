import 'package:flutter/material.dart';

class TaskListScreen extends StatefulWidget {
  static const String routeName = '/tasklist';

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [
    Task(title: 'Công việc 1'),
    Task(title: 'Công việc 2'),
  ];

  final TextEditingController _taskController = TextEditingController();

  // Hàm thêm công việc mới
  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(title: _taskController.text));
        _taskController.clear();
      });
    }
  }

  // Hàm xóa công việc
  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // Hàm chỉnh sửa công việc
  void _editTask(int index) {
    _taskController.text = tasks[index].title;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chỉnh sửa công việc'),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(labelText: 'Công việc'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  tasks[index].title = _taskController.text;
                  _taskController.clear();
                });
                Navigator.of(context).pop();
              },
              child: Text('Lưu'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Danh sách công việc'),
      ),
      body: Column(
        children: [
          // TextField để thêm công việc mới
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Thêm công việc',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editTask(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTask(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}
