import 'package:flutter/material.dart';
import 'package:note_app/screens/add_task_list.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  static const String routeName = '/calendar';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Danh sách các item
  List<Map<String, dynamic>> items = [
    {
      'content': 'Công việc 1',
      'time': '09:00 AM',
      'isStarred': false,
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  void _navigateToAddTask() {
    Navigator.pushNamed(context, AddTaskListScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // Update the focused day as well
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      items[index]['isStarred'] = !items[index]['isStarred']; // Chuyển đổi trạng thái
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
                                  items[index]['content'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  items[index]['time'],
                                ),
                                SizedBox(height: 3),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              items[index]['isStarred'] ? Icons.star : Icons.star_border,
                              color: items[index]['isStarred'] ? Colors.amber[400] : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                items[index]['isStarred'] = !items[index]['isStarred'];
                              });
                            },
                          ),
                        ],
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
