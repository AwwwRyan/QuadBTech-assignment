class Movie {
  final String title;
  final String summary;
  final String image;
  final String thumbnail;
  final List<String> genres;
  final double? rating;
  final String premiered;
  final String status;

  Movie({
    required this.title,
    required this.summary,
    required this.image,
    required this.thumbnail,
    required this.genres,
    this.rating,
    required this.premiered,
    required this.status,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['name'] ?? 'No Title',
      summary: json['summary'] ?? 'No Summary',
      image: json['image'] != null ? json['image']['original'] : '',
      thumbnail: json['image'] != null ? json['image']['medium'] : '',
      genres: List<String>.from(json['genres'] ?? []),
      rating: json['rating']['average']?.toDouble(),
      premiered: json['premiered'] ?? 'Unknown',
      status: json['status'] ?? 'Unknown',
    );
  }
} 