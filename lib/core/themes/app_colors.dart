import 'package:flutter/material.dart';

class AppColors {
  // Warna utama (umum untuk light dan dark mode, atau bisa diubah)
  static const Color primaryColor = Color(0xFF3B82F6); // Biru terang
  static const MaterialColor primaryMaterialColor =
      MaterialColor(0xFF3B82F6, <int, Color>{
        50: Color(0xFFE3F2FD),
        100: Color(0xFFBBDEFB),
        200: Color(0xFF90CAF9),
        300: Color(0xFF64B5F6),
        400: Color(0xFF42A5F5),
        500: Color(0xFF3B82F6),
        600: Color(0xFF1E88E5),
        700: Color(0xFF1976D2),
        800: Color(0xFF1565C0),
        900: Color(0xFF0D47A1),
      });

  // Warna sekunder/aksen
  static const Color accentColor = Color(0xFFFACC15); // Kuning

  // Warna status
  static const Color successColor = Color(0xFF10B981); // Hijau
  static const Color errorColor = Color(0xFFEF4444); // Merah
  static const Color warningColor = Color(0xFFF59E0B); // Oranye

  // Warna abu-abu (umum atau bisa disesuaikan untuk dark/light)
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  // --- Warna umum yang sering digunakan di kedua mode ---
  static const Color whiteColor = Color(
    0xFFFFFFFF,
  ); // Ini yang menyebabkan error Anda!
  static const Color blackColor = Color(0xFF000000);

  // --- Warna untuk Light Mode ---
  static const Color light_textColor = Color(0xFF1F2937); // Abu-abu gelap
  static const Color light_lightTextColor = Color(0xFF6B7280); // Abu-abu sedang
  static const Color light_backgroundColor = Color(
    0xFFF9FAFB,
  ); // Abu-abu sangat terang
  static const Color light_cardColor = Color(0xFFFFFFFF);
  static const Color light_inputFillColor = Color(
    0xFFF3F4F6,
  ); // Abu-abu terang untuk input

  // --- Warna untuk Dark Mode ---
  static const Color dark_textColor = Color(0xFFE5E7EB); // Abu-abu terang
  static const Color dark_lightTextColor = Color(
    0xFF9CA3AF,
  ); // Abu-abu sedang terang
  static const Color dark_backgroundColor = Color(0xFF1F2937); // Abu-abu gelap
  static const Color dark_cardColor = Color(
    0xFF374151,
  ); // Abu-abu gelap untuk kartu
  static const Color dark_inputFillColor = Color(
    0xFF4B5563,
  ); // Abu-abu gelap untuk input
}
