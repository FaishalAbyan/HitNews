import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/domain/entities/article_entity.dart';
import 'package:tekmob_hitnews/domain/usecases/news/fetch_news_usecase.dart';

// Enum untuk merepresentasikan status loading
enum NewsStatus { initial, loading, loaded, error }

class NewsProvider extends ChangeNotifier {
  final FetchTopHeadlinesUseCase fetchTopHeadlinesUseCase;
  final SearchArticlesUseCase searchArticlesUseCase;

  NewsProvider({
    required this.fetchTopHeadlinesUseCase,
    required this.searchArticlesUseCase,
  });

  List<ArticleEntity> _articles = [];
  List<ArticleEntity> get articles => _articles;

  NewsStatus _status = NewsStatus.initial;
  NewsStatus get status => _status;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  // Fungsi untuk mengambil berita utama
  Future<void> fetchTopHeadlines({
    String country = 'us',
    String category = 'general',
    String? query,
  }) async {
    _status = NewsStatus.loading; // Set status menjadi loading
    notifyListeners(); // Beri tahu listener (UI) bahwa status berubah

    try {
      _articles = await fetchTopHeadlinesUseCase(
        country: country,
        category: category,
        query: query,
      );
      _status = NewsStatus.loaded; // Set status menjadi loaded jika berhasil
    } catch (e) {
      _status = NewsStatus.error; // Set status menjadi error jika gagal
      _errorMessage = e.toString(); // Simpan pesan error
      print('Error in NewsProvider.fetchTopHeadlines: $e');
    } finally {
      notifyListeners(); // Beri tahu listener (UI) setelah operasi selesai
    }
  }

  // Fungsi untuk mencari berita
  Future<void> searchArticles(String query) async {
    _status = NewsStatus.loading;
    notifyListeners();

    try {
      _articles = await searchArticlesUseCase(query: query);
      _status = NewsStatus.loaded;
    } catch (e) {
      _status = NewsStatus.error;
      _errorMessage = e.toString();
      print('Error in NewsProvider.searchArticles: $e');
    } finally {
      notifyListeners();
    }
  }

  // Metode untuk membersihkan data atau state jika diperlukan
  void clearArticles() {
    _articles = [];
    _status = NewsStatus.initial;
    _errorMessage = '';
    notifyListeners();
  }
}
