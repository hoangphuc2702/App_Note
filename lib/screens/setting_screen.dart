import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/data_local/user_reference.dart';
import '../provider/theme_provider.dart';
import '../resources/dimens.dart'; // Nơi chứa theme management

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
        automaticallyImplyLeading: false,
        backgroundColor: Color(Dimens.ColorValue),
        title: Container(
          alignment: Alignment.center,
          child: Text('Setting'),
        ),
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
                Navigator.pushNamed(context, '/customizeUI');
              },
            ),

            ListTile(
              title: Text('Task Statistics'),
              subtitle: Text('Change Task Statistics'),
              onTap: () {
                Navigator.pushNamed(context, '/taskStatistics');
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
