import 'package:flutter/material.dart';

// App constants as specified in requirements
class AppConstants {
  // Colors from requirements
  static const Color primaryColor = Color(0xFF10B981); // Green - Agriculture
  static const Color secondaryColor = Color(0xFF3B82F6); // Blue - Trust
  static const Color warningColor = Color(0xFFF59E0B); // Orange
  static const Color dangerColor = Color(0xEFC4444); // Red
  static const Color successColor = Color(0xFF22C55E); // Success

  // Typography
  static const String fontFamily = 'Inter';

  // Spacing
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingExtraLarge = 32.0;

  // Border radius
  static const double borderRadius = 8.0;

  // Breakpoints for responsive design
  static const double mobileBreakpoint = 320.0;
  static const double tabletBreakpoint = 768.0;
  static const double desktopBreakpoint = 1024.0;

  // Default image paths
  static const String defaultUserProfile = 'assets/images/default_user.png';
  static const String defaultGroupLogo = 'assets/images/default_group.png';
  static const String defaultAgronomistProfile = 'assets/images/default_agronomist.png';
}

// Helper functions
class AppHelpers {
  // Format currency
  static String formatCurrency(double amount, {String currency = 'USD'}) {
    return '${currency == 'USD' ? '\$' : currency} ${amount.toStringAsFixed(2)}';
  }

  // Format percentage
  static String formatPercentage(double value) {
    return '${value.toStringAsFixed(1)}%';
  }

  // Format date
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Format date with month name
  static String formatDateWithMonth(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // Get credit score color based on score
  static Color getCreditScoreColor(int score) {
    if (score >= 750) {
      return AppConstants.successColor;
    } else if (score >= 650) {
      return Colors.amber;
    } else if (score >= 550) {
      return AppConstants.warningColor;
    } else {
      return AppConstants.dangerColor;
    }
  }

  // Get credit score status text based on score
  static String getCreditScoreStatus(int score) {
    if (score >= 750) {
      return 'EXCELLENT';
    } else if (score >= 650) {
      return 'GOOD';
    } else if (score >= 550) {
      return 'FAIR';
    } else {
      return 'POOR';
    }
  }
}

// Responsive helper
class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.tabletBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.tabletBreakpoint &&
        MediaQuery.of(context).size.width < AppConstants.desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;
  }
}