import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/provider/notification_provider.dart';
import 'package:note_app/provider/theme_provider.dart';
import 'package:note_app/screens/add_task_list.dart';
import 'package:note_app/screens/custom_UI_screen.dart';
import 'package:note_app/screens/edit_task_list.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/setting_screen.dart';
import 'package:note_app/screens/signin_screens.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/splash_screen.dart';
import 'package:note_app/screens/task_list.dart';
import 'package:note_app/screens/task_statistics_screen.dart';

// Giả sử đây là màn hình Welcome
import 'package:note_app/screens/welcome_screens.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()), // Thêm NotificationProvider
      ],
      child: MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      theme: themeProvider.isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      title: 'App Note',
      home: SplashScreen(),
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        WelcomeScreens.routeName: (context) => WelcomeScreens(),
        LoginScreen.routeName: (context) => LoginScreen(),
        TaskListScreen.routeName: (context) => TaskListScreen(),
        AddTaskListScreen.routeName: (context) => AddTaskListScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        CustomUiScreen.routeName: (context) => CustomUiScreen(),
        TaskStatisticsScreen.routeName: (context) => TaskStatisticsScreen(),

      },
    );
  }
}
