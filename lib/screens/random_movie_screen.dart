import 'dart:math';

import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../models/movie_data.dart';
import '../widgets/movie_card.dart';

class RandomMovieScreen extends StatefulWidget {
  const RandomMovieScreen({super.key});

  @override
  State<RandomMovieScreen> createState() => _RandomMovieScreenState();
}

class _RandomMovieScreenState extends State<RandomMovieScreen> {
  Movie? selectedMovie;

  String selectedGenre = 'All';

  final List<String> genres = [
    'All',
    'Action',
    'Drama',
    'Crime',
    'Sci-Fi',
    'Adventure',
  ];

  void pickMovie() {
    final movies = selectedGenre == 'All'
        ? allMovies
        : allMovies
              .where((movie) => movie.genres.contains(selectedGenre))
              .toList();

    if (movies.isEmpty) {
      return;
    }

    final random = Random();

    setState(() {
      selectedMovie = movies[random.nextInt(movies.length)];
    });
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
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: selectedMovie == null
                  ? const Center(
                      child: Column(
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
                      ),
                    )
                  : MovieCard(movie: selectedMovie!),
            ),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: pickMovie,
                icon: const Icon(Icons.casino),
                label: const Text(
                  'Pick a Movie',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
