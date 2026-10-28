import 'dart:async';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/movie.dart';
import '../services/tmdb_service.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final TmdbService tmdbService = TmdbService();

  Timer? _debounce;

  List<Movie> searchResults = [];
  String selectedGenre = 'All';

  bool isLoading = false;
  String? errorMessage;

  int _searchRequestId = 0;

  final List<String> genres = [
    'All',
    'Action',
    'Drama',
    'Crime',
    'Sci-Fi',
    'Adventure',
  ];

  String _localizedGenre(AppLocalizations l10n, String genre) {
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

  List<Movie> get filteredMovies {
    return searchResults.where((movie) {
      return selectedGenre == 'All' || movie.genres.contains(selectedGenre);
    }).toList();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    final query = value.trim();
    final requestId = ++_searchRequestId;

    if (query.length < 2) {
      setState(() {
        searchResults = [];
        isLoading = false;
        errorMessage = null;
      });
      return;
    }

    setState(() {
      searchResults = [];
      isLoading = true;
      errorMessage = null;
    });

    _debounce = Timer(
      const Duration(milliseconds: 500),
      () => _searchMovies(query, requestId),
    );
  }

  Future<void> _searchMovies(String query, int requestId) async {
    if (query.trim().length < 2) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final movies = await tmdbService.searchMovies(query);

      if (!mounted || requestId != _searchRequestId) {
        return;
      }

      setState(() {
        searchResults = movies;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted || requestId != _searchRequestId) {
        return;
      }

      setState(() {
        isLoading = false;
        errorMessage = 'error';
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final movies = filteredMovies;
    final query = searchController.text.trim();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.searchMovies,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: _onSearchChanged,
              onSubmitted: (value) {
                _debounce?.cancel();

                final submittedQuery = value.trim();
                final requestId = ++_searchRequestId;

                if (submittedQuery.length >= 2) {
                  _searchMovies(submittedQuery, requestId);
                }
              },
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: query.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                          _onSearchChanged('');
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
                  label: Text(_localizedGenre(l10n, genre)),
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

          Expanded(child: _buildResults(query, movies, l10n)),
        ],
      ),
    );
  }

  Widget _buildResults(
    String query,
    List<Movie> movies,
    AppLocalizations l10n,
  ) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.couldNotLoadMovies, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  final requestId = ++_searchRequestId;
                  _searchMovies(query, requestId);
                },
                child: Text(l10n.tryAgain),
              ),
            ],
          ),
        ),
      );
    }

    if (query.length < 2) {
      return Center(
        child: Text(
          query.isEmpty ? l10n.searchHint : l10n.enterAtLeastTwoCharacters,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (movies.isEmpty) {
      return Center(
        child: Text(l10n.noMoviesFound, style: const TextStyle(fontSize: 18)),
      );
    }

    return GridView.builder(
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
    );
  }
}
