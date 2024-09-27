import 'package:flutter/material.dart';
import 'package:note_app/screens/task_list.dart';

class EditTaskListScreen extends StatefulWidget {
  static const String routeName = '/edittask';
  final Task task; // Thêm biến task

  // Constructor với tham số task
  EditTaskListScreen({required this.task});

  @override
  _EditTaskListScreenState createState() => _EditTaskListScreenState();
}

class _EditTaskListScreenState extends State<EditTaskListScreen> {
  late TextEditingController _titleController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    // Khởi tạo controller với giá trị của task
    _titleController = TextEditingController(text: widget.task.title);
    _timeController = TextEditingController(text: widget.task.time);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chỉnh sửa công việc'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Tiêu đề'),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Thời gian'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Cập nhật nhiệm vụ và quay lại
                Navigator.of(context).pop(
                  Task(
                    title: _titleController.text,
                    time: _timeController.text,
                    isStarred: widget.task.isStarred, // Giữ nguyên trạng thái isStarred
                  ),
                );
              },
              child: Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }
}
