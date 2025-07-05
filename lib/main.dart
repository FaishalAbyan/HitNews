import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';
import 'package:tekmob_hitnews/core/themes/theme_provider.dart'; // Import ThemeProvider
import 'package:tekmob_hitnews/data/repositories/news_repository.dart';
import 'package:tekmob_hitnews/data/services/api_service.dart';
import 'package:tekmob_hitnews/domain/usecases/news/fetch_news_usecase.dart';
import 'package:tekmob_hitnews/presentation/auth/pages/onboarding_page.dart';
import 'package:tekmob_hitnews/presentation/providers/news_provider.dart';
import 'package:tekmob_hitnews/presentation/providers/bookmark_provider.dart';

void main() {
  final ApiService apiService = ApiService();
  final NewsRepository newsRepository = NewsRepositoryImpl(apiService);
  final FetchTopHeadlinesUseCase fetchTopHeadlinesUseCase =
      FetchTopHeadlinesUseCase(newsRepository);
  final SearchArticlesUseCase searchArticlesUseCase = SearchArticlesUseCase(
    newsRepository,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (context) => NewsProvider(
                fetchTopHeadlinesUseCase: fetchTopHeadlinesUseCase,
                searchArticlesUseCase: searchArticlesUseCase,
              ),
        ),
        ChangeNotifierProvider(create: (context) => BookmarkProvider()),
        ChangeNotifierProvider(
          // Tambahkan ThemeProvider
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan Consumer untuk mendengarkan perubahan tema
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'TekMob HitNews',
          debugShowCheckedModeBanner: false,
          themeMode:
              themeProvider.themeMode, // Mengatur themeMode dari ThemeProvider
          // Tema Light Mode
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: AppColors.primaryMaterialColor,
            scaffoldBackgroundColor: AppColors.light_backgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.light_backgroundColor,
              elevation: 0,
              iconTheme: const IconThemeData(color: AppColors.light_textColor),
              titleTextStyle: AppTextStyles.appBarTitle.copyWith(
                color: AppColors.light_textColor,
              ),
            ),
            cardColor: AppColors.light_cardColor,
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.light_textColor,
              displayColor: AppColors.light_textColor,
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppColors.light_inputFillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColors.errorColor,
                  width: 2.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColors.errorColor,
                  width: 2.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              hintStyle:
                  AppTextStyles
                      .hintTextStyle, // Akan di-override di setiap widget
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                textStyle: AppTextStyles.buttonTextStyle,
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                textStyle: AppTextStyles.smallLinkTextStyle,
              ),
            ),
          ),

          // Tema Dark Mode
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: AppColors.primaryMaterialColor,
            scaffoldBackgroundColor: AppColors.dark_backgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.dark_backgroundColor,
              elevation: 0,
              iconTheme: const IconThemeData(color: AppColors.dark_textColor),
              titleTextStyle: AppTextStyles.appBarTitle.copyWith(
                color: AppColors.dark_textColor,
              ),
            ),
            cardColor: AppColors.dark_cardColor,
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.dark_textColor,
              displayColor: AppColors.dark_textColor,
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppColors.dark_inputFillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColors.errorColor,
                  width: 2.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColors.errorColor,
                  width: 2.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              hintStyle:
                  AppTextStyles
                      .hintTextStyle, // Akan di-override di setiap widget
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                textStyle: AppTextStyles.buttonTextStyle,
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                textStyle: AppTextStyles.smallLinkTextStyle,
              ),
            ),
          ),
          home: const OnboardingPage(),
        );
      },
    );
  }
}
