import 'dart:convert'; // Untuk mengelola JSON
import 'package:http/http.dart' as http; // Alias untuk paket http
import 'package:tekmob_hitnews/core/constants/api_constants.dart'; // Import konstanta API
import 'package:tekmob_hitnews/data/models/article_model.dart'; // Import ArticleModel

class ApiService {
  final String _baseUrl = ApiConstants.baseUrl;
  final String _apiKey = ApiConstants.newsApiKey;

  // Fungsi untuk mengambil berita utama (top headlines)
  Future<List<ArticleModel>> getTopHeadlines({
    String country = ApiConstants.defaultCountry,
    String category = ApiConstants.defaultCategory,
    String? query, // Parameter opsional untuk pencarian
  }) async {
    // Membangun URL untuk endpoint top-headlines
    Uri uri = Uri.parse('$_baseUrl${ApiConstants.topHeadlinesEndpoint}');

    // Menambahkan parameter query
    Map<String, String> queryParams = {
      'country': country,
      'category': category,
      'apiKey': _apiKey,
    };

    if (query != null && query.isNotEmpty) {
      queryParams['q'] = query; // Tambahkan query jika ada
    }

    uri = uri.replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri); // Melakukan panggilan HTTP GET

      if (response.statusCode == 200) {
        // Jika respons sukses (status code 200 OK)
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'ok' && data['articles'] != null) {
          // Mengurai daftar artikel dari respons JSON
          List<dynamic> articlesJson = data['articles'];
          return articlesJson
              .map((json) => ArticleModel.fromJson(json)) // Mengkonversi setiap item JSON ke ArticleModel
              .toList();
        } else {
          // Menangani kasus jika status bukan 'ok' atau articles null
          throw Exception('Failed to load articles: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        // Jika respons tidak sukses
        throw Exception('Failed to load articles. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Menangani error jaringan atau parsing
      print('Error fetching top headlines: $e');
      rethrow; // Melemparkan kembali error agar bisa ditangani di lapisan atas
    }
  }

  // Fungsi untuk mengambil berita berdasarkan pencarian (everything)
  Future<List<ArticleModel>> searchArticles({
    required String query,
    String? language, // Misalnya 'en', 'id'
    String? sortBy, // Misalnya 'relevancy', 'popularity', 'publishedAt'
  }) async {
    Uri uri = Uri.parse('$_baseUrl${ApiConstants.everythingEndpoint}');

    Map<String, String> queryParams = {
      'q': query,
      'apiKey': _apiKey,
    };

    if (language != null && language.isNotEmpty) {
      queryParams['language'] = language;
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      queryParams['sortBy'] = sortBy;
    }

    uri = uri.replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'ok' && data['articles'] != null) {
          List<dynamic> articlesJson = data['articles'];
          return articlesJson
              .map((json) => ArticleModel.fromJson(json))
              .toList();
        } else {
          throw Exception('Failed to search articles: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Failed to search articles. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching articles: $e');
      rethrow;
    }
  }
}
