// ignore_for_file: constant_identifier_names

class Dimens {
  //font size
  static double FontSize = 25;

  // google font settings
  static String GoogleFont = 'Roboto';

  // color settings
  static int ColorValue = 0xFF8C52FF; // Default purple color

  // Functions to update global settings
  static void updateGoogleFont(String font) {
    GoogleFont = font;
  }

  // Functions to update global settings
  static void updateFontSize(double font) {
    FontSize = font;
  }

  static void updatePrimaryColor(int colorValue) {
    ColorValue = colorValue;
  }

  // Function to reset all values to default
  static void resetToDefaults() {
    FontSize = 25;
    GoogleFont = 'Roboto';
    ColorValue = 0xFF2196F3;
  }
}
