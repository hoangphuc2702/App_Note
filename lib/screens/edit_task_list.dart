import 'package:flutter/material.dart';
import 'package:note_app/model/task.dart';
import 'package:intl/intl.dart'; // Dùng để định dạng ngày

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

  String? _selectedLeader;
  List<String> _leaders = ['Thanh Ngân', 'Hữu Nghĩa', 'Nguyễn Văn A'];
  String? _selectedStatus;
  List<String> _statuses = ['Tạo mới', 'Đang thực hiện', 'Thành công', 'Kết thúc'];

  DateTime? _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(widget.task.date),
    );
    _contentController = TextEditingController(text: widget.task.content);
    _timeController = TextEditingController(text: widget.task.time);
    _locationController = TextEditingController(text: widget.task.location);
    _noteController = TextEditingController(text: widget.task.note);
  }

  @override
  void dispose() {
    _dateController.dispose();
    _contentController.dispose();
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
            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: 'Ghi chú'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(
                  Task(
                    content: _contentController.text,
                    time: _timeController.text,
                    location: _locationController.text,
                    date: _selectedDate ?? widget.task.date,
                    host: widget.task.host,
                    isStarred: widget.task.isStarred,
                    note: _noteController.text,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                  'Lưu',
                  // style: TextStyle(color: Colors.white)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
