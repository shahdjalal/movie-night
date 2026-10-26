class Movie {
  final int id;
  final String title;
  final String posterPath;
  final double rating;
  final String releaseDate;
  final String overview;
  final List<String> genres;
  final int runtime;

  const Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.rating,
    required this.releaseDate,
    required this.overview,
    required this.genres,
    required this.runtime,
  });

  // تحويل بيانات الفيلم القادمة من TMDB.
  factory Movie.fromJson(Map<String, dynamic> json) {
    final poster = json['poster_path'];

    return Movie(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? 'Unknown',
      posterPath: poster != null
          ? 'https://image.tmdb.org/t/p/w500$poster'
          : '',
      rating: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date']?.toString() ?? '',
      overview: json['overview']?.toString() ?? '',
      genres: const [],
      runtime: 0,
    );
  }

  // تحويل البيانات القادمة من طلب تفاصيل الفيلم.
  factory Movie.fromDetailsJson(Map<String, dynamic> json) {
    final List genresData = json['genres'] as List? ?? [];
    final poster = json['poster_path'];

    return Movie(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? 'Unknown',
      posterPath: poster != null
          ? 'https://image.tmdb.org/t/p/w500$poster'
          : '',
      rating: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date']?.toString() ?? '',
      overview: json['overview']?.toString() ?? '',
      genres: genresData
          .map((genre) => genre['name'].toString())
          .toList(),
      runtime: (json['runtime'] as num?)?.toInt() ?? 0,
    );
  }

  // تحويل الفيلم إلى Map حتى نستطيع حفظه.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'rating': rating,
      'releaseDate': releaseDate,
      'overview': overview,
      'genres': genres,
      'runtime': runtime,
    };
  }

  // إعادة الفيلم المحفوظ إلى كائن Movie.
  factory Movie.fromStorageJson(Map<String, dynamic> json) {
    final List genresData = json['genres'] as List? ?? [];

    return Movie(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? 'Unknown',
      posterPath: json['posterPath']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['releaseDate']?.toString() ?? '',
      overview: json['overview']?.toString() ?? '',
      genres: genresData.map((genre) => genre.toString()).toList(),
      runtime: (json['runtime'] as num?)?.toInt() ?? 0,
    );
  }
}