import 'package:intl/intl.dart';

class Task {
  final String? id;
  String content;
  DateTime date;
  String time;
  String location;
  final List<String> host;
  String? note;
  String status; // Trạng thái công việc
  String? approver; // Người thực hiện kiểm duyệt
  bool isStarred; // Đảm bảo thuộc tính này đã được định nghĩa


  // Các giá trị trạng thái
  static const String statusTaoMoi = "tạo mới";
  static const String statusThucHien = "thực hiện";
  static const String statusThanhCong = "thành công";
  static const String statusKetThuc = "kết thúc";

  Task({
    this.id,
    required this.content,
    required this.date,
    required this.time,
    required this.location,
    required this.host,
    this.note,
    this.status = statusTaoMoi, // Gán giá trị mặc định
    this.approver,
    this.isStarred = false,
  });

  // Tạo đối tượng Task từ JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'],
      content: json['content'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      location: json['location'],
      host: List<String>.from(json['host'] ?? []),
      note: json['note'],
      status: json['status'] ?? statusTaoMoi, // Nếu không tìm thấy, dùng mặc định
      approver: json['approver'],
    );
  }

  // Chuyển đối tượng Task thành JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'date': date.toIso8601String(),
      'time': time,
      'location': location,
      'host': host,
      'note': note,
      'status': status, // Trả về chuỗi trạng thái
      'approver': approver,
    };
  }

  static String getFormattedDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }
}
