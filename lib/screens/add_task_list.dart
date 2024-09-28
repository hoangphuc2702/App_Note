import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/screens/home_screen.dart';

import '../data/api.dart';

class AddTaskListScreen extends StatefulWidget {
  static const String routeName = '/addtask';

  @override
  _AddTaskListScreenState createState() => _AddTaskListScreenState();
}

class _AddTaskListScreenState extends State<AddTaskListScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<String> _selectedHosts = [];
  List<String> _hosts = [];
  List<String> _filteredHosts = [];
  List<String> _statuses = ['Tạo mới', 'Đang thực hiện', 'Thành công', 'Kết thúc'];

  DateTime? _selectedDate;

  API api = API();

  @override
  void initState() {
    super.initState();
    _getListNameUser();

    _searchController.addListener(() {
      setState(() {
        // Lọc danh sách chủ trì theo từ khóa tìm kiếm
        _filteredHosts = _hosts
            .where((host) =>
            host.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _contentController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _noteController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}"; // Định dạng ngày
      });
    }
  }

  Future<void> _getListNameUser() async {
    _hosts = await api.getNameUsers();
    setState(() {
      _filteredHosts = _hosts;
    });
  }

  Future<void> _addTask() async {
    String date = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    final content = _contentController.text;
    final time = _timeController.text;
    final location = _locationController.text;
    final note = _noteController.text;

    if (content.isEmpty || date.isEmpty || time.isEmpty || location.isEmpty) {
      _showFailDialog("Add task fail", "All fields are required.");
      return;
    }

    final res = await api.addTask(content, date, time, location, _selectedHosts, note, _statuses[0], '');

    if (res == "true") {
      // Nếu đăng nhập thành công, chuyển đến TaskListScreen
      Navigator.pushNamed(context, HomeScreen.routeName);
    } else {
      _showFailDialog("Add task fail", res);
    }
  }

  void _showFailDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Công Việc Mới'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Nội dung công việc',
                border: InputBorder.none,
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Ngày',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              readOnly: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Thời gian'),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    _timeController.text = pickedTime.format(context);
                  });
                }
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Địa điểm'),
            ),
            SizedBox(height: 16),
            // Thêm trường tìm kiếm cho danh sách chủ trì
            TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: 'Tìm chủ trì'),
            ),
            SizedBox(height: 16),
            // Hiển thị danh sách chủ trì đã lọc
            SizedBox(
              height: 120, // Set a fixed height for the scrollable area
              child: SingleChildScrollView(
                child: Column(
                  children: _filteredHosts.map((String host) {
                    return CheckboxListTile(
                      title: Text(host),
                      value: _selectedHosts.contains(host),
                      onChanged: (bool? isChecked) {
                        setState(() {
                          if (isChecked != null) {
                            if (isChecked) {
                              _selectedHosts.add(host);
                            } else {
                              _selectedHosts.remove(host);
                            }
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: 'Ghi chú'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTask,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Lưu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
