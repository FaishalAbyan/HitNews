import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController(
    text: 'John Doe',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'john.doe@example.com',
  );
  final TextEditingController _bioController = TextEditingController(
    text:
        'Penggemar berita teknologi dan inovasi terkini. Selalu ingin tahu hal baru!',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    print('Saving profile...');
    print('Name: ${_nameController.text}');
    print('Email: ${_emailController.text}');
    print('Bio: ${_bioController.text}');

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil berhasil diperbarui!'),
        backgroundColor: AppColors.successColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Edit Profil'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                hintText: 'Masukkan nama lengkap Anda',
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Theme.of(context).iconTheme.color,
                ),
                labelStyle: AppTextStyles.getInputLabelStyle(context),
                hintStyle: AppTextStyles.getHintTextStyle(context),
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'Masukkan email Anda',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
                labelStyle: AppTextStyles.getInputLabelStyle(context),
                hintStyle: AppTextStyles.getHintTextStyle(context),
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              ),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _bioController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Bio',
                hintText: 'Ceritakan tentang diri Anda',
                prefixIcon: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).iconTheme.color,
                ),
                labelStyle: AppTextStyles.getInputLabelStyle(context),
                hintStyle: AppTextStyles.getHintTextStyle(context),
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Simpan Perubahan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
