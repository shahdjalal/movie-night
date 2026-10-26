import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/movie_data.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  String selectedGenre = 'All';

  List<Movie> get filteredMovies {
    final query = searchController.text.toLowerCase();

    return allMovies.where((movie) {
      final matchesSearch =
          movie.title.toLowerCase().contains(query);

      final matchesGenre =
          selectedGenre == 'All' ||
          movie.genres.contains(selectedGenre);

      return matchesSearch && matchesGenre;
    }).toList();
  }

  final List<String> genres = [
    'All',
    'Action',
    'Drama',
    'Crime',
    'Sci-Fi',
    'Adventure',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Movies',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search for a movie...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.06),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 45,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final genre = genres[index];

                return ChoiceChip(
                  label: Text(genre),
                  selected: selectedGenre == genre,
                  onSelected: (_) {
                    setState(() {
                      selectedGenre = genre;
                    });
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: filteredMovies.isEmpty
                ? const Center(
                    child: Text(
                      'No movies found 🎬',
                      style: TextStyle(fontSize: 18),
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
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(
                        movie: filteredMovies[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}