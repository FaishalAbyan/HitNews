import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';
import 'package:tekmob_hitnews/presentation/home/widgets/news_list_item.dart';
import 'package:tekmob_hitnews/presentation/providers/bookmark_provider.dart';
import 'package:tekmob_hitnews/presentation/news/pages/news_detail_page.dart';

class BookmarkedNewsPage extends StatelessWidget {
  const BookmarkedNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor, // Warna dinamis
      appBar: AppBar(title: const Text('Berita Tersimpan'), centerTitle: true),
      body: Consumer<BookmarkProvider>(
        builder: (context, bookmarkProvider, child) {
          if (bookmarkProvider.bookmarkedArticles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 80,
                    color: Theme.of(context).iconTheme.color,
                  ), // Warna dinamis
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada berita yang disimpan.',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ), // Warna dinamis
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Simpan berita favorit Anda untuk dibaca nanti.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ), // Warna dinamis
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: bookmarkProvider.bookmarkedArticles.length,
              itemBuilder: (context, index) {
                final article = bookmarkProvider.bookmarkedArticles[index];
                return NewsListItem(
                  article: article,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(article: article),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
