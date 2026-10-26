import 'package:flutter/material.dart';
import '../services/movie_lists_service.dart';
import '../widgets/movie_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lists = MovieListsService.instance;

    return AnimatedBuilder(
      animation: lists,
      builder: (context, child) {
        final movies = lists.favoriteMovies;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Favorites',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: movies.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 60,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 12),
                      Text('No favorite movies yet'),
                      SizedBox(height: 6),
                      Text('Add movies from their details page'),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
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