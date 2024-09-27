import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/data_local/user_reference.dart';
import '../provider/theme_provider.dart'; // Nơi chứa theme management

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  Future<void> _logout() async {
    await UserPreferences.clearUserData();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chức năng Dark Mode
            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ),

            // Chức năng Customizable UI
            ListTile(
              title: Text('Customizable UI'),
              subtitle: Text('Change UI preferences'),
              onTap: () {
                // Chuyển hướng đến trang tùy chỉnh UI nếu cần
                Navigator.pushNamed(context, '/customizeUI');
              },
            ),

            // Chức năng Logout
            ListTile(
              title: Text('Logout'),
              trailing: Icon(Icons.logout),
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }
}
