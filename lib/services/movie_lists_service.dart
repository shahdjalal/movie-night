import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movie.dart';

class MovieListsService extends ChangeNotifier {
  MovieListsService._();

  static final MovieListsService instance =
      MovieListsService._();

  static const String _favoritesKey = 'favorite_movies';
  static const String _watchlistKey = 'watchlist_movies';

  List<Movie> _favoriteMovies = [];
  List<Movie> _watchlistMovies = [];

  List<Movie> get favoriteMovies =>
      List.unmodifiable(_favoriteMovies);

  List<Movie> get watchlistMovies =>
      List.unmodifiable(_watchlistMovies);

  bool isFavorite(int movieId) {
    return _favoriteMovies.any((movie) => movie.id == movieId);
  }

  bool isInWatchlist(int movieId) {
    return _watchlistMovies.any((movie) => movie.id == movieId);
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    _favoriteMovies = _decodeMovies(
      prefs.getString(_favoritesKey),
    );

    _watchlistMovies = _decodeMovies(
      prefs.getString(_watchlistKey),
    );

    notifyListeners();
  }

  List<Movie> _decodeMovies(String? savedData) {
    if (savedData == null || savedData.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> decoded = jsonDecode(savedData);

      return decoded.map((item) {
        return Movie.fromStorageJson(
          Map<String, dynamic>.from(item as Map),
        );
      }).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> toggleFavorite(Movie movie) async {
    if (isFavorite(movie.id)) {
      _favoriteMovies.removeWhere(
        (item) => item.id == movie.id,
      );
    } else {
      _favoriteMovies.add(movie);
    }

    notifyListeners();
    await _saveMovies(_favoritesKey, _favoriteMovies);
  }

  Future<void> toggleWatchlist(Movie movie) async {
    if (isInWatchlist(movie.id)) {
      _watchlistMovies.removeWhere(
        (item) => item.id == movie.id,
      );
    } else {
      _watchlistMovies.add(movie);
    }

    notifyListeners();
    await _saveMovies(_watchlistKey, _watchlistMovies);
  }

  Future<void> _saveMovies(
    String key,
    List<Movie> movies,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final encoded = jsonEncode(
      movies.map((movie) => movie.toJson()).toList(),
    );

    await prefs.setString(key, encoded);
  }
}