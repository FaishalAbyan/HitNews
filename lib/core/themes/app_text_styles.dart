import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart';

class AppTextStyles {
  // Judul Besar
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    // Warna akan ditentukan di ThemeData berdasarkan mode tema
  );

  // Judul Halaman (misalnya, "Hello Again!")
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    // Warna akan ditentukan di ThemeData berdasarkan mode tema
  );

  // Sub-judul atau judul bagian
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    // Warna akan ditentukan di ThemeData berdasarkan mode tema
  );

  // Judul AppBar
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    // Warna akan ditentukan di ThemeData berdasarkan mode tema
  );

  // Judul Kartu atau Item List
  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    // Warna akan ditentukan di ThemeData berdasarkan mode tema
  );

  // Sub-judul kecil
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    // Warna akan ditentukan di ThemeData berdasarkan mode tema
  );

  // Body teks standar
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    // Warna akan ditentukan di ThemeData berdasarkan mode tema
  );

  // Body teks kecil
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    // Warna akan ditentukan di ThemeData berdasarkan mode tema
  );

  // Teks sangat kecil (misalnya, timestamp)
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    // Warna akan ditentukan di ThemeData berdasarkan mode tema
  );

  // Gaya teks untuk tombol utama (biasanya putih/hitam, tidak berubah)
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor, // Tetap putih untuk tombol primary
  );

  // Gaya teks untuk hint di input field
  static const TextStyle hintTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    // Warna akan ditentukan di ThemeData berdasarkan mode tema
  );

  // Gaya teks untuk link kecil
  static const TextStyle smallLinkTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor, // Tetap primaryColor
  );

  // Gaya teks untuk error message
  static const TextStyle errorTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.errorColor, // Tetap errorColor
  );

  // Gaya teks untuk label input field
  static const TextStyle inputLabelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    // Warna akan ditentukan di ThemeData berdasarkan mode tema
  );

  // Metode untuk mendapatkan TextStyle dengan warna yang sesuai
  static TextStyle getTextStyle(TextStyle baseStyle, BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return baseStyle.copyWith(
      color: isDarkMode ? AppColors.dark_textColor : AppColors.light_textColor,
    );
  }

  static TextStyle getLightTextStyle(
    TextStyle baseStyle,
    BuildContext context,
  ) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return baseStyle.copyWith(
      color:
          isDarkMode
              ? AppColors.dark_lightTextColor
              : AppColors.light_lightTextColor,
    );
  }

  static TextStyle getHintTextStyle(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AppTextStyles.hintTextStyle.copyWith(
      color: isDarkMode ? AppColors.grey400 : AppColors.grey500,
    );
  }

  static TextStyle getInputLabelStyle(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AppTextStyles.inputLabelStyle.copyWith(
      color: isDarkMode ? AppColors.dark_textColor : AppColors.light_textColor,
    );
  }
}
