import 'dart:math' as math;
import 'package:flutter/material.dart';

// Accessibility helper for WCAG 2.1 AA compliance
class AccessibilityHelper {
  // Ensure sufficient color contrast (at least 4.5:1 for normal text, 3:1 for large text)
  static bool hasSufficientContrast(Color foreground, Color background) {
    final fgLuminance = _getRelativeLuminance(foreground);
    final bgLuminance = _getRelativeLuminance(background);
    
    final ratio = fgLuminance > bgLuminance 
        ? (fgLuminance + 0.05) / (bgLuminance + 0.05)
        : (bgLuminance + 0.05) / (fgLuminance + 0.05);
    
    return ratio >= 4.5; // Minimum for normal text
  }

  static double _getRelativeLuminance(Color color) {
    final r = _normalizeColorComponent(color.red);
    final g = _normalizeColorComponent(color.green);
    final b = _normalizeColorComponent(color.blue);
    
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  static double _normalizeColorComponent(int component) {
    final val = component / 255.0;
    return val <= 0.03928 ? val / 12.92 : math.pow((val + 0.055) / 1.055, 2.4).toDouble();
  }

  // Create accessible text with proper contrast
  static TextStyle getAccessibleTextStyle({
    Color? textColor,
    Color? backgroundColor,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    final effectiveTextColor = textColor ?? Colors.black;
    final effectiveBackgroundColor = backgroundColor ?? Colors.white;
    
    // Ensure sufficient contrast
    if (!hasSufficientContrast(effectiveTextColor, effectiveBackgroundColor)) {
      // Adjust to ensure contrast - for dark backgrounds use light text
      if (effectiveBackgroundColor.computeLuminance() < 0.5) {
        return TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
      } else {
        return TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
      }
    }
    
    return TextStyle(
      color: effectiveTextColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  // Create accessible buttons
  static Widget buildAccessibleButton({
    required VoidCallback onPressed,
    required String label,
    Widget? child,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: backgroundColor ?? Colors.blue,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: child ?? Text(
              label,
              style: getAccessibleTextStyle(
                textColor: foregroundColor ?? Colors.white,
                backgroundColor: backgroundColor ?? Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Create accessible icon buttons
  static Widget buildAccessibleIconButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String tooltip,
    Color? iconColor,
  }) {
    return Semantics(
      button: true,
      label: tooltip,
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        onPressed: onPressed,
        tooltip: tooltip,
        splashRadius: 24, // Ensure touch target is at least 44x44
      ),
    );
  }
}