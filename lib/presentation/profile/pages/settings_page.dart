import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';
import 'package:tekmob_hitnews/core/themes/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _receiveNotifications = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkModeEnabled = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Pengaturan'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Umum',
            style: AppTextStyles.titleLarge.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: Theme.of(context).cardColor,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Mode Gelap (Dark Mode)',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    trailing: Switch(
                      value: isDarkModeEnabled,
                      onChanged: (bool value) {
                        themeProvider.toggleTheme(value);
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                    leading: Icon(
                      Icons.dark_mode_outlined,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Divider(
                    indent: 16,
                    endIndent: 16,
                    color: Theme.of(context).dividerColor,
                  ),
                  ListTile(
                    title: Text(
                      'Bahasa',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    leading: Icon(
                      Icons.language,
                      color: AppColors.primaryColor,
                    ),
                    onTap: () {
                      print('Language settings tapped');
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Notifikasi',
            style: AppTextStyles.titleLarge.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: Theme.of(context).cardColor,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Terima Notifikasi',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    trailing: Switch(
                      value: _receiveNotifications,
                      onChanged: (bool value) {
                        setState(() {
                          _receiveNotifications = value;
                          print(
                            'Receive Notifications: $_receiveNotifications',
                          );
                        });
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                    leading: Icon(
                      Icons.notifications_active_outlined,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Divider(
                    indent: 16,
                    endIndent: 16,
                    color: Theme.of(context).dividerColor,
                  ),
                  ListTile(
                    title: Text(
                      'Pengaturan Suara & Getar',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    leading: Icon(
                      Icons.volume_up_outlined,
                      color: AppColors.primaryColor,
                    ),
                    onTap: () {
                      print('Sound & Vibration settings tapped');
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Akun',
            style: AppTextStyles.titleLarge.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: Theme.of(context).cardColor,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Ubah Kata Sandi',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    leading: Icon(
                      Icons.lock_outline,
                      color: AppColors.primaryColor,
                    ),
                    onTap: () {
                      print('Change Password tapped');
                    },
                  ),
                  Divider(
                    indent: 16,
                    endIndent: 16,
                    color: Theme.of(context).dividerColor,
                  ),
                  ListTile(
                    title: Text(
                      'Hapus Akun',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.errorColor,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    leading: Icon(
                      Icons.delete_outline,
                      color: AppColors.errorColor,
                    ),
                    onTap: () {
                      print('Delete Account tapped');
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Lain-lain',
            style: AppTextStyles.titleLarge.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: Theme.of(context).cardColor,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Tentang Aplikasi',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    leading: Icon(
                      Icons.info_outline,
                      color: AppColors.primaryColor,
                    ),
                    onTap: () {
                      print('About App tapped');
                    },
                  ),
                  Divider(
                    indent: 16,
                    endIndent: 16,
                    color: Theme.of(context).dividerColor,
                  ),
                  ListTile(
                    title: Text(
                      'Kebijakan Privasi',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    leading: Icon(
                      Icons.policy_outlined,
                      color: AppColors.primaryColor,
                    ),
                    onTap: () {
                      print('Privacy Policy tapped');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
