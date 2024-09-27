import 'package:flutter/material.dart';
import 'package:note_app/screens/calendar_screen.dart';
import 'package:note_app/screens/setting_screen.dart';
import 'package:note_app/screens/task_list.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Index hiện tại của BottomNavigationBar
  int _selectedIndex = 0;

  // Các trang con tương ứng với các mục trên BottomNavigationBar
  final List<Widget> _pages = <Widget>[
    TaskListScreen(),   // Trang công việc
    CalendarScreen(), // Trang lịch
    SettingsScreen(), // Trang cài đặt
  ];

  // Thay đổi chỉ mục khi người dùng nhấn vào mục BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Công việc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Lịch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, // Xử lý khi nhấn vào mục
      ),
    );
  }
}
