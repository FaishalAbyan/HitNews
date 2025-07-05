import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekmob_hitnews/core/constants/api_constants.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';
import 'package:tekmob_hitnews/core/routes/custom_page_route.dart';
import 'package:tekmob_hitnews/presentation/home/widgets/news_list_item.dart';
import 'package:tekmob_hitnews/presentation/providers/news_provider.dart';
import 'package:tekmob_hitnews/presentation/news/pages/news_detail_page.dart';
import 'package:tekmob_hitnews/presentation/notifications/pages/notification_page.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart'; // Import animasi

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = ApiConstants.defaultCategory;

  final List<String> _categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchTopHeadlines(
        country: ApiConstants.defaultCountry,
        category: _selectedCategory,
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      Provider.of<NewsProvider>(context, listen: false).fetchTopHeadlines(
        country: ApiConstants.defaultCountry,
        category: _selectedCategory,
      );
    } else {
      Provider.of<NewsProvider>(context, listen: false).searchArticles(query);
    }
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _searchController.clear();
    });
    Provider.of<NewsProvider>(context, listen: false).fetchTopHeadlines(
      country: ApiConstants.defaultCountry,
      category: _selectedCategory,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 100,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/app_logo.png',
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              height: 40,
                              width: 40,
                              color: Theme.of(context).dividerColor,
                              child: Icon(
                                Icons.newspaper,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat datang di',
                              style: AppTextStyles.bodySmall.copyWith(
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                              ),
                            ),
                            Text(
                              'HitNews',
                              style: AppTextStyles.titleLarge.copyWith(
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.titleLarge?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(child: const NotificationPage()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari berita...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).iconTheme.color,
                ),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            _performSearch('');
                          },
                        )
                        : null,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                hintStyle: AppTextStyles.getHintTextStyle(context),
              ),
              onFieldSubmitted: _performSearch,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(
                        category[0].toUpperCase() + category.substring(1),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color:
                              isSelected
                                  ? AppColors.whiteColor
                                  : Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.color,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: AppColors.primaryColor,
                      backgroundColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      onSelected: (selected) {
                        if (selected) {
                          _onCategorySelected(category);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide.none,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<NewsProvider>(
                builder: (context, newsProvider, child) {
                  if (newsProvider.status == NewsStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else if (newsProvider.status == NewsStatus.error) {
                    return Center(
                      child: Text(
                        'Gagal memuat berita: ${newsProvider.errorMessage}',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.errorColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (newsProvider.articles.isEmpty) {
                    return Center(
                      child: Text(
                        'Tidak ada berita ditemukan.',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return AnimationLimiter(
                      // Tambahkan AnimationLimiter
                      child: ListView.builder(
                        itemCount: newsProvider.articles.length,
                        itemBuilder: (context, index) {
                          final article = newsProvider.articles[index];
                          return AnimationConfiguration.staggeredList(
                            // Konfigurasi animasi
                            position: index,
                            duration: const Duration(
                              milliseconds: 375,
                            ), // Durasi per item
                            child: SlideAnimation(
                              // Efek slide
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                // Efek fade
                                child: NewsListItem(
                                  article: article,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CustomPageRoute(
                                        child: NewsDetailPage(article: article),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
