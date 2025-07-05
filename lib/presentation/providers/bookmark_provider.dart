import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/domain/entities/article_entity.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<ArticleEntity> _bookmarkedArticles = [];

  List<ArticleEntity> get bookmarkedArticles => _bookmarkedArticles;

  // Menambahkan artikel ke bookmark
  void addBookmark(ArticleEntity article) {
    if (!_bookmarkedArticles.contains(article)) {
      _bookmarkedArticles.add(article);
      notifyListeners();
      print('Article bookmarked: ${article.title}');
    }
  }

  // Menghapus artikel dari bookmark
  void removeBookmark(ArticleEntity article) {
    _bookmarkedArticles.remove(article);
    notifyListeners();
    print('Article unbookmarked: ${article.title}');
  }

  // Memeriksa apakah artikel sudah di-bookmark
  bool isBookmarked(ArticleEntity article) {
    return _bookmarkedArticles.contains(article);
  }

  // Membersihkan semua bookmark (untuk logout atau reset)
  void clearBookmarks() {
    _bookmarkedArticles.clear();
    notifyListeners();
    print('All bookmarks cleared.');
  }
}
