import 'package:flutter/material.dart';
import '../services/movie_lists_service.dart';
import '../widgets/movie_card.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lists = MovieListsService.instance;

    return AnimatedBuilder(
      animation: lists,
      builder: (context, child) {
        final movies = lists.watchlistMovies;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Watchlist',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: movies.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bookmark_border, size: 60, color: Colors.grey),
                      SizedBox(height: 12),
                      Text('Your watchlist is empty'),
                      SizedBox(height: 6),
                      Text('Add movies you want to watch'),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.58,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(movie: movies[index]);
                  },
                ),
        );
      },
    );
  }
}
