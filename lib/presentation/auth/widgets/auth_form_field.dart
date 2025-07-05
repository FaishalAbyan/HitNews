import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart'; // Import AppTextStyles

class AuthFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator; // Untuk validasi form

  const AuthFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false, // Default tidak di-obscure
    this.suffixIcon,
    this.keyboardType = TextInputType.text, // Default keyboard type
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: AppTextStyles.bodyLarge.copyWith(
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ), // Gaya teks input
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon:
            prefixIcon != null
                ? Icon(
                  prefixIcon,
                  color: Theme.of(context).iconTheme.color,
                ) // Warna ikon dinamis
                : null,
        suffixIcon: suffixIcon,
        labelStyle: AppTextStyles.getInputLabelStyle(
          context,
        ), // Gaya label dinamis
        hintStyle: AppTextStyles.getHintTextStyle(context), // Gaya hint dinamis
        fillColor:
            Theme.of(
              context,
            ).inputDecorationTheme.fillColor, // Warna fill dinamis
      ),
    );
  }
}
