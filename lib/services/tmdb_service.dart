import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie.dart';

class TmdbService {
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String token = String.fromEnvironment('TMDB_TOKEN');

  Future<List<Movie>> getPopularMovies() async {
    final url = Uri.parse('$baseUrl/movie/popular');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token', 'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List results = data['results'];

      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final url = Uri.parse('$baseUrl/movie/top_rated');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token', 'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List results = data['results'];

      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    final url = Uri.parse('$baseUrl/movie/$movieId');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token', 'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return Movie.fromDetailsJson(data);
    } else {
      throw Exception('Failed to load movie details: ${response.statusCode}');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
  if (token.isEmpty) {
    throw Exception(
      'TMDB token is missing. Run with --dart-define=TMDB_TOKEN=...',
    );
  }

  final url = Uri.parse('$baseUrl/search/movie').replace(
    queryParameters: {
      'query': query,
      'include_adult': 'false',
      'language': 'en-US',
      'page': '1',
    },
  );

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List results = data['results'] ?? [];

    return results
        .map((json) => Movie.fromJson(
              Map<String, dynamic>.from(json),
            ))
        .toList();
  } else {
    throw Exception(
      'Failed to search movies: ${response.statusCode}',
    );
  }
}

}
