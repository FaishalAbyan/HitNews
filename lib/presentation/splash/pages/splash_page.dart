import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/core/routes/custom_page_route.dart';
import 'package:tekmob_hitnews/presentation/auth/pages/onboarding_page.dart'; // Import OnboardingPage
import 'package:tekmob_hitnews/presentation/main_wrapper_page.dart'; // Import MainWrapperPage
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase untuk cek sesi
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart'; // **PERBAIKAN: path yang benar adalah 'themes' bukan 'theme'**

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatusAndNavigate();
  }

  Future<void> _checkAuthStatusAndNavigate() async {
    // Tunggu 2 detik untuk menampilkan splash screen
    await Future.delayed(const Duration(seconds: 3));

    // Dapatkan sesi Supabase saat ini
    final session = Supabase.instance.client.auth.currentSession;

    // Tentukan halaman tujuan berdasarkan status autentikasi
    Widget nextPage;
    if (session != null) {
      // Jika ada sesi aktif, langsung ke MainWrapperPage
      nextPage = const MainWrapperPage();
    } else {
      // Jika tidak ada sesi, tampilkan OnboardingPage
      nextPage = const OnboardingPage();
    }

    // Navigasi ke halaman tujuan dengan animasi
    if (mounted) {
      Navigator.of(context).pushReplacement(CustomPageRoute(child: nextPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(
            context,
          ).scaffoldBackgroundColor, // Menggunakan warna latar belakang tema
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo HitNews
            ClipRRect(
              borderRadius: BorderRadius.circular(
                22.0,
              ), // Rounded corners untuk logo
              child: Image.asset(
                'assets/images/app_logo.png', //
                height: 150, // Ukuran logo yang lebih besar
                width: 150,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Icon(
                        Icons.newspaper,
                        size: 80,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
              ),
            ),
            const SizedBox(height: 24),
            // Nama Aplikasi
            Text(
              'HitNews',
              style: AppTextStyles.headlineLarge.copyWith(
                color: Theme.of(context).textTheme.headlineLarge?.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Slogan atau Tagline
            Text(
              'Baca Berita Dimana Saja, Kapan Saja',
              style: AppTextStyles.bodyLarge.copyWith(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
