import 'package:note_app/screens/add_task_list.dart';
import 'package:note_app/screens/edit_task_list.dart';
import 'package:note_app/screens/signin_screens.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/task_list.dart';

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
      home: WelcomeScreens(),
      routes: {
        WelcomeScreens.routeName: (context) => WelcomeScreens(),
        LoginScreen.routeName: (context) => LoginScreen(),
        TaskListScreen.routeName: (context) => TaskListScreen(),
        AddTaskListScreen.routeName: (context) => AddTaskListScreen(),
      },
    );
  }
}
