import 'package:flutter/material.dart';
import '../services/movie_lists_service.dart';
import '../models/movie.dart';
import '../services/tmdb_service.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final TmdbService tmdbService = TmdbService();

  Movie? movieDetails;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadMovieDetails();
  }

  Future<void> loadMovieDetails() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final details = await tmdbService.getMovieDetails(widget.movie.id);

      if (!mounted) return;

      setState(() {
        movieDetails = details;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        errorMessage = 'Could not load movie details.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // نعرض بيانات القائمة مؤقتًا حتى تصل التفاصيل الكاملة.
    final movie = movieDetails ?? widget.movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 430,
            pinned: true,
            backgroundColor: const Color(0xFF0F0F14),
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'movie-${widget.movie.id}',
                child: movie.posterPath.isNotEmpty
                    ? Image.network(
                        movie.posterPath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            color: Colors.grey.shade900,
                            child: const Icon(Icons.movie, size: 70),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey.shade900,
                        child: const Icon(Icons.movie, size: 70),
                      ),
              ),
            ),
          ),

          if (isLoading)
            const SliverToBoxAdapter(child: LinearProgressIndicator()),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (errorMessage != null) ...[
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                    TextButton.icon(
                      onPressed: loadMovieDetails,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try again'),
                    ),
                    const SizedBox(height: 12),
                  ],

                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 6),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      Text(
                        movie.releaseDate.isNotEmpty
                            ? movie.releaseDate
                            : 'Release date unavailable',
                      ),

                      if (movie.runtime > 0) Text('${movie.runtime} min'),
                    ],
                  ),

                  if (movie.genres.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: movie.genres.map((genre) {
                        return Chip(label: Text(genre));
                      }).toList(),
                    ),
                  ],

                  const SizedBox(height: 24),

                  const Text(
                    'Overview',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    movie.overview.isNotEmpty
                        ? movie.overview
                        : 'No overview available.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.grey.shade300,
                    ),
                  ),

                  const SizedBox(height: 28),

                  AnimatedBuilder(
                    animation: MovieListsService.instance,
                    builder: (context, child) {
                      final lists = MovieListsService.instance;
                      final isFavorite = lists.isFavorite(movie.id);
                      final isInWatchlist = lists.isInWatchlist(movie.id);

                      return Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await lists.toggleFavorite(movie);
                              },
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                              ),
                              label: Text(
                                isFavorite ? 'Favorited' : 'Favorite',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                await lists.toggleWatchlist(movie);
                              },
                              icon: Icon(
                                isInWatchlist
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                              ),
                              label: Text(
                                isInWatchlist ? 'In Watchlist' : 'Watchlist',
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
