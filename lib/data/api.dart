import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/data_local/user_reference.dart';
import '../model/task.dart';
import '../model/user.dart';


class API {
  String baseUrl = "http://192.168.12.104:3000";

  Future<List<Task>> getTasks() async {
    List<Task> data = [];

    final uri = Uri.parse('$baseUrl/task/getTasks');
    try {
      final res = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if(res.statusCode == 200){
        final List<dynamic> jsonData = json.decode(res.body);
        data = jsonData.map((json) => Task.fromJson(json)).toList();
      }
      return data;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<String>> getNameUsers() async {
    List<String> data = [];

    final uri = Uri.parse('$baseUrl/user/getUsers');
    try {
      final res = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if(res.statusCode == 200){
        final List<dynamic> jsonData = json.decode(res.body);
        data = jsonData.map((json) => User.fromJson(json).name).toList();
      }
      return data;
    } catch (ex) {
      rethrow;
    }
  }

  Future<Task> getTaskByName(String name) async {
    Task? data;

    final uri = Uri.parse('$baseUrl/task/searchTaskbyname/$name');

    try {
      final res = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if(res.statusCode == 200){
        final Map<String, dynamic> jsonData = json.decode(res.body);
        data = Task.fromJson(jsonData);
      }
      return data!;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<Task>> getTaskByDate(String date) async {
    List<Task> data = [];

    final uri = Uri.parse('$baseUrl/task/searchTaskbydate/$date');
    try {
      final res = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(res.body);
        data = jsonData.map((json) => Task.fromJson(json)).toList();
      }
      return data;
    } catch (ex) {
      rethrow;
    }
  }

  // Future<Task> getUserByName(String name) async {
  //   Task? data;
  //
  //   final uri = Uri.parse('$baseUrl/task/searchTask/$name');
  //
  //   try {
  //     final res = await http.get(
  //       uri,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8'
  //       },
  //     );
  //     if(res.statusCode == 200){
  //       final Map<String, dynamic> jsonData = json.decode(res.body);
  //       data = Task.fromJson(jsonData);
  //     }
  //     return data!;
  //   } catch (ex) {
  //     rethrow;
  //   }
  // }

  Future<String> addTask(
      String content,
      String date,
      String time,
      String location,
      List<String> hosts,
      String note,
      String status,
      String approver) async {

    final uri = Uri.parse('$baseUrl/task/insertTask');

    try {
      final body = json.encode({
        "content": content,
        "date": date,
        "time": time,
        "location": location,
        "host": hosts,
        "note": note,
        "status": status,
        "approver": approver,
      });

      final res = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (res.statusCode == 201) {
        final Map<String, dynamic> jsonData = json.decode(res.body);
        print(jsonData);
        return "true";
      } else {
        print("Failed with status code: ${res.statusCode}, body: ${res.body}");
        return "false";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> updateTask(String taskId,
      String content,
      String date,
      String time,
      String location,
      List<String> hosts,
      String note,
      String status,
      String approver) async {

    final uri = Uri.parse('$baseUrl/task/updateTask/$taskId');

    try {
      final body = json.encode({
        'content': content,
        'date': date,
        'time': time,
        'location': location,
        'host': hosts,
        'note': note,
        'status': status,
        'approver': approver,
      });

      final res = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (res.statusCode == 200) {
        print("success");
        return "true";
      } else {
        print("Failed with status code: ${res.statusCode}, body: ${res.body}");
        return "false";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> deleteTask(String taskId) async {
    final uri = Uri.parse('$baseUrl/task/deleteTask/$taskId');

    try {
      final res = await http.delete(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 200) {
        print("Task deleted successfully");
        return "true";
      } else {
        print("Failed with status code: ${res.statusCode}, body: ${res.body}");
        return "false";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> registerUser(String name, String email, String password, String urlImage) async {
    final uri = Uri.parse('$baseUrl/user/insertUser');

    try {
      final body = json.encode({
        'name': name,
        'mail': email,
        'pass': password,
        'urlImage': urlImage,
      });

      final res = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (res.statusCode == 201) {
        final Map<String, dynamic> jsonData = json.decode(res.body);
        print(jsonData);
        return "true"; // Đăng ký thành công
      } else {
        print("Failed with status code: ${res.statusCode}, body: ${res.body}");
        return "false"; // Đăng ký không thành công
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> loginUser(String email, String password) async {
    final uri = Uri.parse('$baseUrl/user/login'); // Endpoint đăng nhập

    try {
      final body = json.encode({
        'mail': email,
        'pass': password,
      });

      final res = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(res.body);
        print(jsonData);

        // Lưu ID và thông tin người dùng vào SharedPreferences
        String userId = jsonData['user']['_id']; // Lấy ID người dùng
        await UserPreferences.setUserId(userId); // Lưu ID
        await UserPreferences.setUser(jsonData['user']); // Lưu thông tin người dùng


        return "true"; // Đăng nhập thành công
      } else {
        print("Failed with status code: ${res.statusCode}, body: ${res.body}");
        return "false"; // Đăng nhập không thành công
      }
    } catch (ex) {
      print(ex);
      rethrow; // Ném lại ngoại lệ
    }
  }
}
