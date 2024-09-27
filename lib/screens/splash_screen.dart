import 'package:flutter/material.dart';
import 'package:note_app/screens/welcome_screens.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'Splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _splashScreen();
  }

  // Kiểm tra trạng thái đăng nhập
  Future<void> _splashScreen() async {
    // Delay 5 giây
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, WelcomeScreens.routeName);
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
