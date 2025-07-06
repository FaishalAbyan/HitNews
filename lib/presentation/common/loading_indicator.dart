import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart'; // Import AppColors

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor, // Menggunakan warna primer aplikasi
      ),
    );
  }
}
