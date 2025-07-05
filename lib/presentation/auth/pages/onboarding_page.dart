import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';
import 'package:tekmob_hitnews/core/routes/custom_page_route.dart';
import 'package:tekmob_hitnews/presentation/auth/pages/login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> onboardingData = [
    {
      'icon': Icons.newspaper_outlined, // Menggunakan ikon
      'color': AppColors.primaryColor,
      'title': 'Berita Terkini di Ujung Jari Anda',
      'description':
          'Dapatkan informasi terbaru dan terpercaya dari berbagai sumber terkemuka, langsung di genggaman Anda.',
    },
    {
      'icon': Icons.person_outline, // Menggunakan ikon
      'color': AppColors.accentColor,
      'title': 'Personalisasi Sesuai Minat Anda',
      'description':
          'Pilih kategori berita favorit Anda dan nikmati feed yang disesuaikan khusus untuk Anda.',
    },
    {
      'icon': Icons.bookmark_border, // Menggunakan ikon
      'color': AppColors.successColor,
      'title': 'Baca Kapan Saja, Di Mana Saja',
      'description':
          'Simpan artikel untuk dibaca nanti, bahkan saat offline. Informasi selalu tersedia untuk Anda.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 24.0,
                    ), // Padding lebih besar
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Visual (Ikon)
                        Icon(
                          onboardingData[index]['icon']!,
                          size: 120, // Ukuran ikon lebih besar
                          color:
                              onboardingData[index]['color'], // Warna ikon dinamis
                        ),
                        const SizedBox(height: 48),
                        // Judul
                        Text(
                          onboardingData[index]['title']!,
                          style: AppTextStyles.headlineMedium.copyWith(
                            color:
                                Theme.of(
                                  context,
                                ).textTheme.headlineMedium?.color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        // Deskripsi
                        Text(
                          onboardingData[index]['description']!,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Dot Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => AnimatedContainer(
                  // Animasi untuk dot
                  duration: const Duration(milliseconds: 300),
                  height: 8,
                  width:
                      _currentPage == index
                          ? 28
                          : 8, // Lebar dot yang aktif lebih panjang
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index
                            ? AppColors.primaryColor
                            : Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Tombol Navigasi
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child:
                  _currentPage == onboardingData.length - 1
                      ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              CustomPageRoute(child: const LoginPage()),
                            );
                          },
                          child: const Text('Mulai Sekarang'),
                        ),
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                CustomPageRoute(
                                  child: const LoginPage(),
                                ), // Langsung ke Login
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color, // Warna dinamis
                            ),
                            child: const Text('Lewati'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            child: const Text('Selanjutnya'),
                          ),
                        ],
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
