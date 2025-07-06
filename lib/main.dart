import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';
import 'package:tekmob_hitnews/core/themes/theme_provider.dart';
import 'package:tekmob_hitnews/data/repositories/news_repository.dart';
import 'package:tekmob_hitnews/data/services/api_service.dart';
import 'package:tekmob_hitnews/domain/usecases/news/fetch_news_usecase.dart';
// Hapus import OnboardingPage dan MainWrapperPage di sini jika hanya digunakan di SplashPage
// import 'package:tekmob_hitnews/presentation/auth/pages/onboarding_page.dart';
// import 'package:tekmob_hitnews/presentation/main_wrapper_page.dart';
import 'package:tekmob_hitnews/presentation/providers/news_provider.dart';
import 'package:tekmob_hitnews/presentation/providers/bookmark_provider.dart';
import 'package:tekmob_hitnews/data/services/auth_service.dart';
import 'package:tekmob_hitnews/data/repositories/auth_repository.dart';
import 'package:tekmob_hitnews/domain/usecases/auth/sign_in_usecase.dart';
import 'package:tekmob_hitnews/domain/usecases/auth/sign_up_usecase.dart';
import 'package:tekmob_hitnews/domain/usecases/auth/sign_out_usecase.dart';
import 'package:tekmob_hitnews/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:tekmob_hitnews/presentation/providers/auth_provider.dart';
import 'package:tekmob_hitnews/presentation/splash/pages/splash_page.dart'; // Import SplashPage

// Fungsi utama aplikasi
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:
        'https://pdwgewmsglrssycymotg.supabase.co', 
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBkd2dld21zZ2xyc3N5Y3ltb3RnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE3ODcwMzksImV4cCI6MjA2NzM2MzAzOX0.SXZP6qHFwxc5KaPJ-xBKy_ab7p6cX-X2iPhR_dBfAzI', 
    debug: true,
  );

  final ApiService apiService = ApiService();
  final NewsRepository newsRepository = NewsRepositoryImpl(apiService);
  final FetchTopHeadlinesUseCase fetchTopHeadlinesUseCase =
      FetchTopHeadlinesUseCase(newsRepository);
  final SearchArticlesUseCase searchArticlesUseCase = SearchArticlesUseCase(
    newsRepository,
  );

  final AuthService authService = AuthService();
  final AuthRepository authRepository = AuthRepositoryImpl(authService);
  final SignInUseCase signInUseCase = SignInUseCase(authRepository);
  final SignUpUseCase signUpUseCase = SignUpUseCase(authRepository);
  final SignOutUseCase signOutUseCase = SignOutUseCase(authRepository);
  final GetCurrentUserUseCase getCurrentUserUseCase = GetCurrentUserUseCase(
    authRepository,
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
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
          create:
              (context) => AuthProvider(
                signInUseCase: signInUseCase,
                signUpUseCase: signUpUseCase,
                signOutUseCase: signOutUseCase,
                getCurrentUserUseCase: getCurrentUserUseCase,
              )..checkCurrentUser(),
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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'TekMob HitNews',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
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
              hintStyle: AppTextStyles.hintTextStyle,
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
              hintStyle: AppTextStyles.hintTextStyle,
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
          // Mengarahkan home ke SplashPage
          home: const SplashPage(),
        );
      },
    );
  }
}
