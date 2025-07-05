import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';
import 'package:tekmob_hitnews/domain/entities/article_entity.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:tekmob_hitnews/presentation/providers/bookmark_provider.dart';

class NewsDetailPage extends StatelessWidget {
  final ArticleEntity article;

  const NewsDetailPage({super.key, required this.article});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('id', timeago.IdMessages());

    DateTime? publishedDate;
    try {
      publishedDate = DateTime.parse(article.publishedAt);
    } catch (e) {
      publishedDate = null;
    }

    return Consumer<BookmarkProvider>(
      builder: (context, bookmarkProvider, child) {
        final bool isBookmarked = bookmarkProvider.isBookmarked(article);

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: const Text('Detail Berita'),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 0,
            iconTheme: Theme.of(context).appBarTheme.iconTheme,
            titleTextStyle: AppTextStyles.appBarTitle.copyWith(
              color: Theme.of(context).appBarTheme.titleTextStyle?.color,
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color:
                      isBookmarked
                          ? AppColors.primaryColor
                          : Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  if (isBookmarked) {
                    bookmarkProvider.removeBookmark(article);
                  } else {
                    bookmarkProvider.addBookmark(article);
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child:
                      article.urlToImage != null &&
                              article.urlToImage!.isNotEmpty
                          ? Image.network(
                            article.urlToImage!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  width: double.infinity,
                                  height: 200,
                                  color: Theme.of(context).dividerColor,
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                          )
                          : Container(
                            width: double.infinity,
                            height: 200,
                            color: Theme.of(context).dividerColor,
                            child: Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                ),
                const SizedBox(height: 20),
                Text(
                  article.title,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: Theme.of(context).textTheme.headlineSmall?.color,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.source,
                      size: 16,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        article.sourceName,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (article.author != null &&
                        article.author!.isNotEmpty) ...[
                      Icon(
                        Icons.person,
                        size: 16,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          article.author!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      publishedDate != null
                          ? timeago.format(publishedDate, locale: 'id')
                          : 'Waktu tidak diketahui',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (article.description != null &&
                    article.description!.isNotEmpty) ...[
                  Text(
                    article.description!,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                if (article.content != null && article.content!.isNotEmpty) ...[
                  Text(
                    article.content!,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _launchUrl(article.url);
                    },
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Baca Selengkapnya'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
