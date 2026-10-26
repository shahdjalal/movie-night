import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../screens/movie_details_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: movie)),
        );
      },
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'movie-${movie.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  movie.posterPath,
                  width: 140,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 140,
                      height: 200,
                      color: Colors.grey.shade800,
                      child: const Icon(Icons.movie, size: 50),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                Text(movie.rating.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
