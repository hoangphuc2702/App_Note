import 'package:flutter/material.dart';
import 'package:note_app/model/task.dart';
import 'package:intl/intl.dart';
import 'package:note_app/screens/home_screen.dart';

import '../data/api.dart'; // Dùng để định dạng ngày

class EditTaskListScreen extends StatefulWidget {
  static const String routeName = '/edittask';
  final Task task;

  EditTaskListScreen({required this.task});

  @override
  _EditTaskListScreenState createState() => _EditTaskListScreenState();
}

class _EditTaskListScreenState extends State<EditTaskListScreen> {
  late TextEditingController _dateController;
  late TextEditingController _contentController;
  late TextEditingController _timeController;
  late TextEditingController _locationController;
  late TextEditingController _noteController;
  late TextEditingController _hostController; // Controller cho tên host
  final TextEditingController _searchController = TextEditingController();

  late String id = '';
  List<String> _selectedHosts = [];
  List<String> _hosts = [];
  String? _selectedStatus;
  List<String> _statuses = ['Tạo mới', 'Đang thực hiện', 'Thành công', 'Kết thúc'];
  List<String> _filteredHosts = [];

  DateTime? _selectedDate;

  API api = API();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getListNameUser();

    _dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(widget.task.date),
    );
    _contentController = TextEditingController(text: widget.task.content);
    _timeController = TextEditingController(text: widget.task.time);
    _locationController = TextEditingController(text: widget.task.location);
    _noteController = TextEditingController(text: widget.task.note);

    _hostController = TextEditingController();
    _selectedHosts = List<String>.from(widget.task.host);

    id = widget.task.id!;

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
    _hostController.dispose();
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

  Future<void> _editTask() async {
    DateTime select = DateFormat('dd/MM/yyyy').parse(_dateController.text);
    final date = DateFormat('yyyy-MM-dd').format(select);
    final content = _contentController.text;
    final time = _timeController.text;
    final location = _locationController.text;
    final note = _noteController.text;

    if (content.isEmpty || date.isEmpty || time.isEmpty || location.isEmpty) {
      _showFailDialog("Edit task fail", "All fields are required.");
      return;
    }

    final res = await api.updateTask(id, content, date, time, location, _selectedHosts, note, _statuses[0], '');

    if (res == "true") {
      Navigator.pushNamed(context, HomeScreen.routeName);
    } else {
      _showFailDialog("Edit task fail", res);
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

  List<String> _filterHosts(String query) {
    return _hosts.where((host) => host.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chỉnh sửa công việc'),
        // backgroundColor: Colors.white,
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
            // TextField cho việc tìm kiếm tên host
            TextField(
              controller: _hostController,
              decoration: InputDecoration(
                labelText: 'Nhập tên host',
              ),
              onChanged: (value) {
                setState(() {
                  _selectedHosts = _filterHosts(value);
                });
              },
            ),
            // Danh sách tên host lọc
            SizedBox(height: 8),
            SizedBox(
              height: 120,
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
              onPressed: _editTask,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
