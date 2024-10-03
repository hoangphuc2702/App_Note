import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note_app/data/api.dart';
import 'package:note_app/screens/add_task_list.dart';
import 'package:note_app/screens/edit_task_list.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model/task.dart';
import '../resources/dimens.dart';

class CalendarScreen extends StatefulWidget {
  static const String routeName = '/calendar';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  API api = API();

  // Danh sách các task
  List<Task> listTask = <Task>[];
  String message = ""; // Thông báo khi không có công việc

  @override
  void initState() {
    super.initState();
    getTaskByDate(_selectedDay.toIso8601String().split('T')[0]); // Lấy công việc ngay khi khởi động
  }

  void _navigateToAddTask() {
    Navigator.pushNamed(context, AddTaskListScreen.routeName);
  }

  void _showCheckDialog(String title, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
                onConfirm(); // Thực hiện hành động xác nhận
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTask(int index) async {
    _showCheckDialog(
      "Xác nhận xóa",
      "Bạn có chắc chắn muốn xóa ghi chú này?",
          () async {
        String id = listTask[index].id.toString();
        final res = await api.deleteTask(id); // Thay đổi để gửi ID của tác vụ

        if (res == "true") {
          setState(() {
            listTask.removeAt(index); // Xóa tác vụ từ danh sách
          });
          _showCheckDialog("Thành công", "Ghi chú đã được xóa thành công!", () {});
        } else {
          _showCheckDialog("Lỗi", res, () {});
        }
      },
    );
  }

  void getTaskByDate(String date) async {
    final result = await api.getTaskByDate(date);

    if (result.length >= 1) {
      // Có công việc
      setState(() {
        listTask = result;
        message = ""; // Xóa thông báo nếu có công việc
      });

    } else {
      // Không có công việc
      setState(() {
        listTask = [];
        message = "Hôm nay không có công việc gì"; // Thiết lập thông báo
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(Dimens.ColorValue),
        title: Container(
          alignment: Alignment.center,
          child: Text('Lịch Công Việc'),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            focusedDay: DateTime.now(), // Thay đổi để không cần _focusedDay
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, _) {
              setState(() {
                _selectedDay = selectedDay;
                getTaskByDate(selectedDay.toIso8601String().split('T')[0]); // Gọi hàm lấy công việc với định dạng YYYY-MM-DD
              });
            },
          ),
          Expanded(
            child: listTask.isEmpty
                ? Center(child: Text(message)) // Hiển thị thông báo nếu không có công việc
                : ListView.builder(
              itemCount: listTask.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(listTask[index]), // Thêm key cho Slidable
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => _deleteTask(index),
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Xóa',
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditTaskListScreen(task: listTask[index]),
                        ),
                      ).then((updatedTask) {
                        if (updatedTask != null) {
                          setState(() {
                            listTask[index] = updatedTask;
                          });
                        }
                      });
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listTask[index].content,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    listTask[index].time,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                listTask[index].isStarred ? Icons.star : Icons.star_border,
                                color: listTask[index].isStarred ? Colors.amber[400] : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  listTask[index].isStarred = !listTask[index].isStarred;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask,
        child: Icon(Icons.add),
        tooltip: 'Thêm công việc',
        shape: CircleBorder(),
      ),
    );
  }
}
