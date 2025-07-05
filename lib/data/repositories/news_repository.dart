import 'package:tekmob_hitnews/data/services/api_service.dart'; // Import ApiService
import 'package:tekmob_hitnews/domain/entities/article_entity.dart'; // Import ArticleEntity

// Antarmuka (abstract class) untuk News Repository
// Ini mendefinisikan kontrak yang harus dipenuhi oleh implementasi repositori
abstract class NewsRepository {
  Future<List<ArticleEntity>> getTopHeadlines({
    String country,
    String category,
    String? query,
  });

  Future<List<ArticleEntity>> searchArticles({
    required String query,
    String? language,
    String? sortBy,
  });
}

// Implementasi konkret dari News Repository
class NewsRepositoryImpl implements NewsRepository {
  final ApiService apiService; // Dependensi ke ApiService

  NewsRepositoryImpl(this.apiService); // Constructor untuk injeksi dependensi

  @override
  Future<List<ArticleEntity>> getTopHeadlines({
    String country = 'us', // Default country
    String category = 'general', // Default category
    String? query,
  }) async {
    try {
      // Memanggil ApiService untuk mendapatkan ArticleModel
      final articleModels = await apiService.getTopHeadlines(
        country: country,
        category: category,
        query: query,
      );
      // Mengkonversi daftar ArticleModel ke daftar ArticleEntity
      return articleModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      print('Error in NewsRepositoryImpl.getTopHeadlines: $e');
      rethrow; // Melemparkan kembali error
    }
  }

  @override
  Future<List<ArticleEntity>> searchArticles({
    required String query,
    String? language,
    String? sortBy,
  }) async {
    try {
      // Memanggil ApiService untuk mendapatkan ArticleModel
      final articleModels = await apiService.searchArticles(
        query: query,
        language: language,
        sortBy: sortBy,
      );
      // Mengkonversi daftar ArticleModel ke daftar ArticleEntity
      return articleModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      print('Error in NewsRepositoryImpl.searchArticles: $e');
      rethrow; // Melemparkan kembali error
    }
  }
}
