import 'package:flutter/material.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/task_list.dart';

import '../data/api.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  API api = API();

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showFailDialog("Login fail", "All fields are required.");
      return;
    }

    final res = await api.loginUser(email, password);

    if (res == "true") {
      // Nếu đăng nhập thành công, chuyển đến TaskListScreen
      Navigator.pushNamed(context, HomeScreen.routeName);
    } else {
      _showFailDialog("Login fail", res);
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
      // backgroundColor: Colors.white,
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
                controller: _emailController,
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
                controller: _passwordController,
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
                onPressed: _login,
                child: Text(
                  'Đăng nhập',
                  // style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white, // Text color
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
                  // style: TextStyle(color: Colors.black),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  // backgroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text.rich(TextSpan(
                  text: 'Chưa có tài khoản? ',
                  // style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Đăng ký',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
