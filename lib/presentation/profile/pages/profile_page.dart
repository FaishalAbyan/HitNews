import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';
import 'package:tekmob_hitnews/core/routes/custom_page_route.dart'; // Import CustomPageRoute
import 'package:tekmob_hitnews/presentation/profile/pages/edit_profile_page.dart';
import 'package:tekmob_hitnews/presentation/auth/pages/login_page.dart';
import 'package:tekmob_hitnews/presentation/profile/pages/settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const String userName = 'John Doe';
    const String userEmail = 'john.doe@example.com';
    const String userBio =
        'Penggemar berita teknologi dan inovasi terkini. Selalu ingin tahu hal baru!';
    const String profileImageUrl =
        'https://placehold.co/120x120/E0E0E0/3B82F6?text=JD';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              Navigator.push(
                context,
                CustomPageRoute(
                  child: const SettingsPage(),
                ), // Menggunakan CustomPageRoute
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.primaryColor.withOpacity(0.2),
              backgroundImage: NetworkImage(profileImageUrl),
              onBackgroundImageError: (exception, stackTrace) {
                print('Error loading profile image: $exception');
              },
              child:
                  profileImageUrl.isEmpty
                      ? Icon(
                        Icons.person,
                        size: 60,
                        color: AppColors.primaryColor,
                      )
                      : null,
            ),
            const SizedBox(height: 20),
            Text(
              userName,
              style: AppTextStyles.headlineSmall.copyWith(
                color: Theme.of(context).textTheme.headlineSmall?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              userEmail,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              userBio,
              style: AppTextStyles.bodyLarge.copyWith(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      child: const EditProfilePage(),
                    ), // Menggunakan CustomPageRoute
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profil'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    CustomPageRoute(
                      child: const LoginPage(),
                    ), // Menggunakan CustomPageRoute
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(Icons.logout, color: AppColors.errorColor),
                label: Text(
                  'Log Out',
                  style: AppTextStyles.buttonTextStyle.copyWith(
                    color: AppColors.errorColor,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.errorColor),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
