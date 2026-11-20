import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie.dart';

class TmdbService {
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String token = String.fromEnvironment('TMDB_TOKEN');

  // دالة موحدة لإرسال طلبات TMDB
  Future<Map<String, dynamic>> _get(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    // 1. التأكد من وجود التوكن
    if (token.trim().isEmpty) {
      throw Exception(
        'TMDB token is missing. Run with --dart-define=TMDB_TOKEN=...',
      );
    }

    // 2. تجهيز رابط الطلب
    final url = Uri.parse(
      '$baseUrl$path',
    ).replace(queryParameters: queryParameters);

    // 3. إرسال الطلب
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token', 'accept': 'application/json'},
    );

    // 4. فحص حالة الاستجابة
    if (response.statusCode == 401 || response.statusCode == 403) {
      throw Exception('TMDB authentication failed. Check your TMDB token.');
    }

    if (response.statusCode != 200) {
      throw Exception(
        'TMDB request failed. Status code: ${response.statusCode}',
      );
    }

    // 5. تحويل JSON إلى Map وإرجاع البيانات
    final data = jsonDecode(response.body);

    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid TMDB response format.');
    }

    return data;
  }

  Future<List<Movie>> getPopularMovies() async {
    final data = await _get('/movie/popular');

    final List results = data['results'] ?? [];

    return results
        .map((json) => Movie.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final data = await _get('/movie/top_rated');

    final List results = data['results'] ?? [];

    return results
        .map((json) => Movie.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<Movie> getMovieDetails(int movieId) async {
    final data = await _get('/movie/$movieId');

    return Movie.fromDetailsJson(data);
  }

  Future<List<Movie>> searchMovies(String query) async {
    final data = await _get(
      '/search/movie',
      queryParameters: {
        'query': query,
        'include_adult': 'false',
        'language': 'en-US',
        'page': '1',
      },
    );

    final List results = data['results'] ?? [];

    return results
        .map((json) => Movie.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }
}
