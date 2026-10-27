import 'dart:math';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../services/tmdb_service.dart';
import '../widgets/movie_card.dart';

class RandomMovieScreen extends StatefulWidget {
  const RandomMovieScreen({super.key});

  @override
  State<RandomMovieScreen> createState() => _RandomMovieScreenState();
}

class _RandomMovieScreenState extends State<RandomMovieScreen> {
  final TmdbService tmdbService = TmdbService();

  // نخزن الأفلام التي جلبناها من TMDB
  List<Movie>? popularMovies;

  Movie? selectedMovie;
  String selectedGenre = 'All';

  bool isLoading = false;
  String? errorMessage;

  final List<String> genres = [
    'All',
    'Action',
    'Drama',
    'Crime',
    'Sci-Fi',
    'Adventure',
  ];

  Future<void> pickMovie() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // نجلب الأفلام من API عند الحاجة فقط
      popularMovies ??= await tmdbService.getPopularMovies();

      // نفلتر الأفلام حسب النوع المختار
      final movies = selectedGenre == 'All'
          ? popularMovies!
          : popularMovies!
                .where((movie) => movie.genres.contains(selectedGenre))
                .toList();

      if (!mounted) return;

      if (movies.isEmpty) {
        setState(() {
          selectedMovie = null;
          isLoading = false;
          errorMessage =
              'No popular movies found for this genre. '
              'Try another genre.';
        });
        return;
      }

      // نختار فيلمًا عشوائيًا
      final random = Random();
      final movie = movies[random.nextInt(movies.length)];

      setState(() {
        selectedMovie = movie;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage =
            'Could not load movies. Check your connection and TMDB token.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick a Movie')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'What do you feel like watching?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: genres.map((genre) {
                return ChoiceChip(
                  label: Text(genre),
                  selected: selectedGenre == genre,
                  onSelected: (_) {
                    setState(() {
                      selectedGenre = genre;
                      selectedMovie = null;
                      errorMessage = null;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : errorMessage != null
                    ? Text(errorMessage!, textAlign: TextAlign.center)
                    : selectedMovie == null
                    ? const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.movie_filter, size: 80),
                          SizedBox(height: 15),
                          Text(
                            'Choose a genre and let us pick!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      )
                    : MovieCard(movie: selectedMovie!),
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : pickMovie,
                icon: const Icon(Icons.casino),
                label: Text(
                  isLoading ? 'Finding a movie...' : 'Pick a Movie',
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
