import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart'; // Import AppTextStyles

class SocialLoginButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Menggunakan Expanded agar tombol mengisi lebar yang tersedia
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          side: BorderSide(
            color: Theme.of(context).dividerColor,
          ), // Warna border dinamis
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor:
              Theme.of(
                context,
              ).cardColor, // Warna latar belakang tombol dinamis
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 24, width: 24),
            const SizedBox(width: 8),
            Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ), // Warna teks dinamis
            ),
          ],
        ),
      ),
    );
  }
}
