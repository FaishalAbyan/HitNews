import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';
import 'package:tekmob_hitnews/presentation/home/widgets/news_list_item.dart';
import 'package:tekmob_hitnews/presentation/news/pages/news_detail_page.dart';
import 'package:tekmob_hitnews/presentation/providers/news_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _dummyTopics = [
    'Health',
    'Technology',
    'Art',
    'Politics',
    'Sport',
    'Travel',
    'Money',
    'Science',
    'Business',
    'Entertainment',
  ];

  final List<String> _dummyAuthors = [
    'John Doe',
    'Jane Smith',
    'Alex Johnson',
    'Maria Garcia',
    'David Lee',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _performNewsSearch(String query) {
    if (query.isNotEmpty) {
      Provider.of<NewsProvider>(context, listen: false).searchArticles(query);
    } else {
      Provider.of<NewsProvider>(context, listen: false).clearArticles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor, // Warna dinamis
      appBar: AppBar(
        title: const Text('Pencarian'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari berita, topik, atau penulis...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).iconTheme.color,
                    ), // Warna dinamis
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Theme.of(context).iconTheme.color,
                              ), // Warna dinamis
                              onPressed: () {
                                _searchController.clear();
                                _performNewsSearch('');
                                setState(() {});
                              },
                            )
                            : null,
                    fillColor:
                        Theme.of(
                          context,
                        ).inputDecorationTheme.fillColor, // Warna dinamis
                    hintStyle: AppTextStyles.getHintTextStyle(
                      context,
                    ), // Warna dinamis
                  ),
                  onFieldSubmitted: (query) {
                    if (_tabController.index == 0) {
                      _performNewsSearch(query);
                    }
                  },
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'News'),
                    Tab(text: 'Topics'),
                    Tab(text: 'Author'),
                  ],
                  labelStyle: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleMedium?.color,
                  ), // Warna dinamis
                  unselectedLabelStyle: AppTextStyles.titleMedium.copyWith(
                    color: Theme.of(context).textTheme.titleMedium?.color,
                  ), // Warna dinamis
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor:
                      Theme.of(context).unselectedWidgetColor, // Warna dinamis
                  indicatorColor: AppColors.primaryColor,
                  indicatorWeight: 3.0,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Consumer<NewsProvider>(
            builder: (context, newsProvider, child) {
              if (newsProvider.status == NewsStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              } else if (newsProvider.status == NewsStatus.error) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Gagal memuat berita: ${newsProvider.errorMessage}',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.errorColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else if (newsProvider.articles.isEmpty &&
                  _searchController.text.isNotEmpty) {
                return Center(
                  child: Text(
                    'Tidak ada berita ditemukan untuk "${_searchController.text}".',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ), // Warna dinamis
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (newsProvider.articles.isEmpty &&
                  _searchController.text.isEmpty) {
                return Center(
                  child: Text(
                    'Masukkan kata kunci untuk mencari berita.',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ), // Warna dinamis
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: newsProvider.articles.length,
                  itemBuilder: (context, index) {
                    final article = newsProvider.articles[index];
                    return NewsListItem(
                      article: article,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => NewsDetailPage(article: article),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _dummyTopics.length,
            itemBuilder: (context, index) {
              final topic = _dummyTopics[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12.0),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Theme.of(context).cardColor, // Warna dinamis
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            topic,
                            style: AppTextStyles.titleMedium.copyWith(
                              color:
                                  Theme.of(
                                    context,
                                  ).textTheme.titleMedium?.color,
                            ), // Warna dinamis
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'View the latest news about ${topic.toLowerCase()}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodySmall?.color,
                            ), // Warna dinamis
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('Save topic: $topic');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.whiteColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _dummyAuthors.length,
            itemBuilder: (context, index) {
              final author = _dummyAuthors[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12.0),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Theme.of(context).cardColor, // Warna dinamis
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            author,
                            style: AppTextStyles.titleMedium.copyWith(
                              color:
                                  Theme.of(
                                    context,
                                  ).textTheme.titleMedium?.color,
                            ), // Warna dinamis
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'View articles by $author',
                            style: AppTextStyles.bodySmall.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodySmall?.color,
                            ), // Warna dinamis
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('Follow author: $author');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentColor,
                          foregroundColor:
                              Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color, // Warna dinamis
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Follow'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
