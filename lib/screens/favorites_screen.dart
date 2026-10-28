import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/movie_lists_service.dart';
import '../widgets/movie_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lists = MovieListsService.instance;
    final l10n = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: lists,
      builder: (context, child) {
        final movies = lists.favoriteMovies;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              l10n.favorites,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: movies.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        size: 60,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 12),
                      Text(l10n.noFavoriteMoviesYet),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          l10n.addMoviesFromDetailsPage,
                          textAlign: TextAlign.center,
                        ),
                      ),
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
