import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';
import 'package:tekmob_hitnews/domain/entities/article_entity.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tekmob_hitnews/presentation/providers/bookmark_provider.dart';

class NewsListItem extends StatelessWidget {
  final ArticleEntity article;
  final VoidCallback? onTap;

  const NewsListItem({super.key, required this.article, this.onTap});

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

        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor, // Warna dinamis
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color:
                      Theme.of(context).brightness == Brightness.light
                          ? AppColors.grey200.withOpacity(0.5)
                          : Colors.black.withOpacity(0.3), // Bayangan dinamis
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child:
                      article.urlToImage != null &&
                              article.urlToImage!.isNotEmpty
                          ? Image.network(
                            article.urlToImage!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  width: 100,
                                  height: 100,
                                  color:
                                      Theme.of(
                                        context,
                                      ).dividerColor, // Warna dinamis
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Theme.of(context).iconTheme.color,
                                  ), // Warna dinamis
                                ),
                          )
                          : Container(
                            width: 100,
                            height: 100,
                            color:
                                Theme.of(context).dividerColor, // Warna dinamis
                            child: Icon(
                              Icons.image_not_supported,
                              color: Theme.of(context).iconTheme.color,
                            ), // Warna dinamis
                          ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: Theme.of(context).textTheme.titleMedium?.color,
                        ), // Warna dinamis
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.source,
                            size: 14,
                            color: Theme.of(context).iconTheme.color,
                          ), // Warna dinamis
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              article.sourceName,
                              style: AppTextStyles.bodySmall.copyWith(
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                              ), // Warna dinamis
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Theme.of(context).iconTheme.color,
                          ), // Warna dinamis
                          const SizedBox(width: 4),
                          Text(
                            publishedDate != null
                                ? timeago.format(publishedDate, locale: 'id')
                                : 'Waktu tidak diketahui',
                            style: AppTextStyles.bodySmall.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodySmall?.color,
                            ), // Warna dinamis
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color:
                        isBookmarked
                            ? AppColors.primaryColor
                            : Theme.of(
                              context,
                            ).iconTheme.color, // Warna dinamis
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
          ),
        );
      },
    );
  }
}
