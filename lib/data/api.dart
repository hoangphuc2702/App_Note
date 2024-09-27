import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/task.dart';


class API {
  String baseUrl = "http://192.168.100.55:3000";

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

  Future<Task> getTaskByName(String name) async {
    Task? data;

    final uri = Uri.parse('$baseUrl/task/searchTask/$name');

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

  Future<String> updateTask(int taskId,
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

  Future<String> deleteTask(int taskId) async {
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
}
