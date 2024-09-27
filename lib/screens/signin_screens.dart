import 'package:flutter/material.dart';
import 'package:note_app/screens/task_list.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo hoặc tiêu đề ứng dụng
            Center(
              child: Text(
                'Daily Planner',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            SizedBox(height: 50),

            // Trường Email
            SizedBox(
              width: 300, // Giới hạn chiều rộng
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(height: 20),

            // Trường Mật khẩu
            SizedBox(
              width: 300, // Giới hạn chiều rộng
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mật khẩu',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250, // Giới hạn chiều rộng
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, TaskListScreen.routeName);
                },
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.deepPurple,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 250,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.school),
                label: Text(
                  'Đăng nhập bằng tài khoản sinh viên',
                  style: TextStyle(color: Colors.black),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
                  children: [
                    Text.rich(TextSpan(
                      text: 'Chưa có tài khoản? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Đăng ký',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
