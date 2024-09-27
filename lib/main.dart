import 'package:note_app/screens/signin_screens.dart';
import 'package:flutter/material.dart';

// Giả sử đây là màn hình Welcome
import 'package:note_app/screens/welcome_screens.dart';

void main() {
  runApp(const MyApp(preferences: 'Default Preferences'));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.preferences});

  final String preferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Note',
      // Bạn có thể chọn sử dụng home hoặc initialRoute
      home: WelcomeScreens(),
      // initialRoute: Welcome_Screens.routeName, // Nếu bạn muốn sử dụng initialRoute, đảm bảo routeName có giá trị phù hợp
      routes: {
        WelcomeScreens.routeName: (context) => WelcomeScreens(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
    );
  }
}
