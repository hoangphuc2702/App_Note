import 'package:flutter/material.dart';

class AddTaskListScreen extends StatefulWidget {
  static const String routeName = '/addtask';

  @override
  _AddTaskListScreenState createState() => _AddTaskListScreenState();
}

class _AddTaskListScreenState extends State<AddTaskListScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _taskContentController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? _selectedLeader;
  List<String> _leaders = ['Thanh Ngân', 'Hữu Nghĩa', 'Nguyễn Văn A'];
  String? _selectedStatus;
  List<String> _statuses = ['Tạo mới', 'Đang thực hiện', 'Thành công', 'Kết thúc'];

  DateTime? _selectedDate;

  @override
  void dispose() {
    _dateController.dispose();
    _taskContentController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _noteController.dispose();
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

  void _addTask() {
    if (_taskContentController.text.isNotEmpty &&
        _selectedDate != null &&
        _selectedLeader != null &&
        _selectedStatus != null) {
      Navigator.pop(context);
    } else {
      // Hiển thị thông báo nếu thiếu thông tin
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng điền đầy đủ thông tin!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Thêm Công Việc Mới'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _taskContentController,
              decoration: InputDecoration(
                labelText: 'Nội dung công việc',
                border: InputBorder.none, // Loại bỏ border
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16), // Space between fields
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Ngày',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              readOnly: true, // Không cho phép nhập trực tiếp
            ),
            SizedBox(height: 16),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Thời gian'),
              readOnly: true, // Không cho phép nhập trực tiếp
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(), // Thời gian mặc định là thời gian hiện tại
                );
                if (pickedTime != null) {
                  // Cập nhật trường thời gian với giá trị đã chọn
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
            DropdownButtonFormField<String>(
              value: _selectedLeader,
              hint: Text('Chọn chủ trì'),
              items: _leaders.map((String leader) {
                return DropdownMenuItem<String>(
                  value: leader,
                  child: Text(leader),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLeader = newValue;
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              hint: Text('Trạng thái công việc'),
              items: _statuses.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: 'Ghi chú'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTask,
              child: Text('Lưu Công Việc'),
            ),
          ],
        ),
      ),
    );
  }
}
