import 'package:flutter/material.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/task_list.dart';
import 'package:note_app/screens/welcome_screens.dart';

import '../model/data_local/user_reference.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'Splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Kiểm tra trạng thái đăng nhập
  Future<void> _checkLoginStatus() async {
    // Delay 5 giây
    await Future.delayed(Duration(seconds: 5));

    String? userId = await UserPreferences.getUserId();

    if (userId != null && userId.isNotEmpty) {
      // Nếu đã đăng nhập, chuyển hướng đến màn hình TaskList
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else{
      Navigator.pushReplacementNamed(context, WelcomeScreens.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.gif',
          height: 150,
          fit: BoxFit.cover,
        ), // Hiển thị loading trong khi kiểm tra đăng nhập
      ),
    );
  }
}
