import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import '../resources/dimens.dart';

class CustomUiScreen extends StatefulWidget {
  static const String routeName = '/customizeUI';

  @override
  _CustomUiScreenState createState() => _CustomUiScreenState();
}

class _CustomUiScreenState extends State<CustomUiScreen> {
  Color _primaryColor = Color(Dimens.ColorValue);
  String _fontFamily = Dimens.GoogleFont;
  double _fontSize = Dimens.FontSize;

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Load saved preferences when the screen initializes
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _primaryColor = Color(prefs.getInt('primaryColor') ?? Dimens.ColorValue);
      _fontFamily = prefs.getString('fontFamily') ?? Dimens.GoogleFont;
      _fontSize = prefs.getDouble('fontSize') ?? Dimens.FontSize;
    });
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('primaryColor', _primaryColor.value);
    await prefs.setString('fontFamily', _fontFamily);
    await prefs.setDouble('fontSize', _fontSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _primaryColor,
        centerTitle: true,
        title: Text(
          'Customize UI',
          style: GoogleFonts.getFont(_fontFamily, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildColorPicker(),
            SizedBox(height: 20),
            _buildFontPicker(),
            SizedBox(height: 20),
            _buildFontSizePicker(),
            SizedBox(height: 40),
            _buildPreview(),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _savePreferences(); // Save preferences when the button is pressed
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Preferences Saved!')),
                );
              },
              child: Text('Lưu', style: GoogleFonts.getFont(_fontFamily)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                minimumSize: Size(100, 25), // Set minimum size (width, height)
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Add padding
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Primary Color', style: GoogleFonts.getFont(_fontFamily, fontSize: _fontSize)),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            Colors.blue,
            Colors.red,
            Colors.green,
            Colors.orange,
            Colors.purple,
          ].map((Color color) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _primaryColor = color;
                  Dimens.updatePrimaryColor(color.value);
                });
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(color: _primaryColor == color ? Colors.black : Colors.transparent, width: 2),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFontPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Font Family', style: GoogleFonts.getFont(_fontFamily, fontSize: _fontSize)),
        SizedBox(height: 10),
        DropdownButton<String>(
          value: _fontFamily,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _fontFamily = newValue;
                Dimens.updateGoogleFont(newValue);
              });
            }
          },
          items: ['Roboto', 'Lato', 'Open Sans', 'Montserrat']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: GoogleFonts.getFont(value)),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFontSizePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Font Size', style: GoogleFonts.getFont(_fontFamily, fontSize: _fontSize)),
        SizedBox(height: 10),
        Slider(
          value: _fontSize,
          min: 12,
          max: 30,
          divisions: 12,
          label: _fontSize.round().toString(),
          onChanged: (double value) {
            setState(() {
              _fontSize = value;
              Dimens.updateFontSize(value);
            });
          },
        ),
      ],
    );
  }

  Widget _buildPreview() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preview',
            style: GoogleFonts.getFont(
              _fontFamily,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'This is how your customized UI will look.',
            style: GoogleFonts.getFont(
              _fontFamily,
              fontSize: _fontSize,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('Sample Button', style: GoogleFonts.getFont(_fontFamily)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
