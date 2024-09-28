import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/data_local/user_reference.dart';
import '../provider/theme_provider.dart'; // Nơi chứa theme management

class CalendarScreen extends StatefulWidget {
  static const String routeName = '/calendar';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
        ),
      ),
    );
  }
}
