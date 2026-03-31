import 'package:flutter/material.dart';

enum ExpiryStatus { expired, expiringSoon, expiringWarning, healthy }

class ExpiryUtils {
  /// Calculate expiry status based on expiry date string (YYYY-MM-DD format)
  /// Returns: expired (red), expiringSoon (red, ≤3 days), expiringWarning (yellow, ≤7 days), healthy (green)
  static ExpiryStatus getExpiryStatus(String expiryDateStr) {
    try {
      final expiryDate = DateTime.parse(expiryDateStr);
      final today = DateTime.now();
      final todayOnly = DateTime(today.year, today.month, today.day);
      final expiryOnly = DateTime(
        expiryDate.year,
        expiryDate.month,
        expiryDate.day,
      );

      final daysUntilExpiry = expiryOnly.difference(todayOnly).inDays;

      if (daysUntilExpiry < 0) {
        return ExpiryStatus.expired;
      } else if (daysUntilExpiry <= 3) {
        return ExpiryStatus.expiringSoon;
      } else if (daysUntilExpiry <= 7) {
        return ExpiryStatus.expiringWarning;
      } else {
        return ExpiryStatus.healthy;
      }
    } catch (e) {
      return ExpiryStatus.healthy; // Default to healthy if parsing fails
    }
  }

  /// Get color for expiry status
  static Color getExpiryColor(ExpiryStatus status) {
    switch (status) {
      case ExpiryStatus.expired:
      case ExpiryStatus.expiringSoon:
        return Colors.red;
      case ExpiryStatus.expiringWarning:
        return Colors.amber;
      case ExpiryStatus.healthy:
        return Colors.green;
    }
  }

  /// Get label text for expiry status
  static String getExpiryLabel(String expiryDateStr) {
    try {
      final expiryDate = DateTime.parse(expiryDateStr);
      final today = DateTime.now();
      final todayOnly = DateTime(today.year, today.month, today.day);
      final expiryOnly = DateTime(
        expiryDate.year,
        expiryDate.month,
        expiryDate.day,
      );

      final daysUntilExpiry = expiryOnly.difference(todayOnly).inDays;

      if (daysUntilExpiry < 0) {
        return "Expired";
      } else if (daysUntilExpiry == 0) {
        return "Expires today";
      } else if (daysUntilExpiry == 1) {
        return "Expires tomorrow";
      } else {
        return "Expires in $daysUntilExpiry days";
      }
    } catch (e) {
      return expiryDateStr;
    }
  }
}
