import 'package:tekmob_hitnews/domain/entities/article_entity.dart'; // Import ArticleEntity
import 'package:tekmob_hitnews/data/repositories/news_repository.dart'; // Import NewsRepository

// Definisi use case untuk mengambil berita utama
class FetchTopHeadlinesUseCase {
  final NewsRepository repository; // Dependensi ke NewsRepository

  // Constructor untuk injeksi dependensi
  FetchTopHeadlinesUseCase(this.repository);

  // Metode yang akan dieksekusi untuk mendapatkan berita utama
  // Parameter opsional untuk negara, kategori, dan query pencarian
  Future<List<ArticleEntity>> call({
    String country = 'us', // Default country
    String category = 'general', // Default category
    String? query, // Optional search query
  }) async {
    try {
      // Memanggil metode dari repository untuk mendapatkan daftar ArticleEntity
      return await repository.getTopHeadlines(
        country: country,
        category: category,
        query: query,
      );
    } catch (e) {
      // Menangani error yang mungkin terjadi dari repository
      print('Error in FetchTopHeadlinesUseCase: $e');
      rethrow; // Melemparkan kembali error agar bisa ditangani di lapisan Presentasi
    }
  }
}

// Definisi use case untuk mencari berita
class SearchArticlesUseCase {
  final NewsRepository repository; // Dependensi ke NewsRepository

  // Constructor untuk injeksi dependensi
  SearchArticlesUseCase(this.repository);

  // Metode yang akan dieksekusi untuk mencari berita
  Future<List<ArticleEntity>> call({
    required String query,
    String? language,
    String? sortBy,
  }) async {
    try {
      // Memanggil metode dari repository untuk mendapatkan daftar ArticleEntity
      return await repository.searchArticles(
        query: query,
        language: language,
        sortBy: sortBy,
      );
    } catch (e) {
      // Menangani error yang mungkin terjadi dari repository
      print('Error in SearchArticlesUseCase: $e');
      rethrow; // Melemparkan kembali error agar bisa ditangani di lapisan Presentasi
    }
  }
}
