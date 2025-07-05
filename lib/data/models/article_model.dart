import 'package:tekmob_hitnews/domain/entities/article_entity.dart'; // Import entitas domain

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required String sourceName,
    required String? author,
    required String title,
    required String? description,
    required String url,
    required String? urlToImage,
    required String publishedAt,
    required String? content,
  }) : super(
          sourceName: sourceName,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      sourceName: json['source']?['name'] ?? 'Unknown Source',
      author: json['author'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String?,
    );
  }

  // Metode untuk mengkonversi dari model ke entity (walaupun di sini sama, ini pola yang baik)
  ArticleEntity toEntity() {
    return ArticleEntity(
      sourceName: sourceName,
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }
}
