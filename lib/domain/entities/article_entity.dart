import 'package:equatable/equatable.dart'; // Paket untuk membandingkan objek

// Tambahkan equatable ke pubspec.yaml jika belum ada:
// dependencies:
//   equatable: ^2.0.5

class ArticleEntity extends Equatable {
  final String sourceName;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  const ArticleEntity({
    required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  @override
  List<Object?> get props => [
        sourceName,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}
