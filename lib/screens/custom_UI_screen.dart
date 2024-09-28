import 'package:flutter/material.dart';

class CustomUiScreen extends StatefulWidget {
  static const String routeName = '/customizeUI';

  @override
  _CustomUiScreenState createState() => _CustomUiScreenState();
}

class _CustomUiScreenState extends State<CustomUiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customize UI'),
      ),
      body: Center(
        child: Text('Tùy chỉnh giao diện UI tại đây'),
      ),
    );
  }
}
