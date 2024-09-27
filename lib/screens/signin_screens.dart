import 'package:flutter/material.dart';

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
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 50),

            // Trường Email
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),

            // Trường Mật khẩu
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mật khẩu',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            // Nút Đăng nhập
            ElevatedButton(
              onPressed: () {
                // Xử lý đăng nhập
              },
              child: Text('Đăng nhập'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            SizedBox(height: 10),

            // Đăng nhập bằng tài khoản sinh viên (SSO)
            OutlinedButton.icon(
              onPressed: () {
                // Xử lý đăng nhập SSO
              },
              icon: Icon(Icons.school),
              label: Text('Đăng nhập bằng tài khoản sinh viên'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),

            // Liên kết đến trang đăng ký
            TextButton(
              onPressed: () {
                // Chuyển hướng đến trang đăng ký
              },
              child: Text('Chưa có tài khoản? Đăng ký'),
            ),
          ],
        ),
      ),
    );
  }
}
