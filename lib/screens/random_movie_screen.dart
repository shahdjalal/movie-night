import 'dart:math';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
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

  String localizedGenre(AppLocalizations l10n, String genre) {
    switch (genre) {
      case 'All':
        return l10n.all;
      case 'Action':
        return l10n.action;
      case 'Drama':
        return l10n.drama;
      case 'Crime':
        return l10n.crime;
      case 'Sci-Fi':
        return l10n.sciFi;
      case 'Adventure':
        return l10n.adventure;
      default:
        return genre;
    }
  }

  Future<void> pickMovie() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      popularMovies ??= await tmdbService.getPopularMovies();

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
          errorMessage = 'noMoviesForGenre';
        });
        return;
      }

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
        errorMessage = 'connectionError';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.pickAMovie)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              l10n.whatToWatch,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: genres.map((genre) {
                return ChoiceChip(
                  label: Text(localizedGenre(l10n, genre)),
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
                    ? Text(
                        errorMessage == 'noMoviesForGenre'
                            ? l10n.noPopularMoviesForGenre
                            : l10n.connectionAndTokenError,
                        textAlign: TextAlign.center,
                      )
                    : selectedMovie == null
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.movie_filter, size: 80),
                          const SizedBox(height: 15),
                          Text(
                            l10n.chooseGenrePrompt,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 17),
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
                  isLoading ? l10n.findingMovie : l10n.pickAMovie,
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
