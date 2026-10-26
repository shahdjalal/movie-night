import 'movie.dart';

const List<Movie> popularMovies = [
  Movie(
    id: 1,
    title: 'Inception',
    posterPath:
        'https://image.tmdb.org/t/p/w500/oYuLEt3zVCKqB97XOxVXT4V8h8J.jpg',
    rating: 8.8,
    releaseDate: '2010',
    genres: ['Action', 'Sci-Fi'],
    runtime: 148,
    overview:
        'A thief who steals corporate secrets through dream-sharing technology is given the task of planting an idea into the mind of a CEO.',
  ),
  Movie(
    id: 2,
    title: 'Interstellar',
    posterPath:
        'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
    rating: 8.7,
    releaseDate: '2014',
    genres: ['Adventure', 'Drama', 'Sci-Fi'],
    runtime: 169,
    overview:
        'A team of explorers travel through a wormhole in space in an attempt to ensure humanity’s survival.',
  ),
  Movie(
    id: 3,
    title: 'The Dark Knight',
    posterPath:
        'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
    rating: 9.0,
    releaseDate: '2008',
    genres: ['Action', 'Crime', 'Drama'],
    runtime: 152,
    overview:
        'Batman faces a criminal mastermind who plunges Gotham City into chaos and forces him to confront his limits.',
  ),
];

const List<Movie> topRatedMovies = [
  Movie(
    id: 4,
    title: 'The Shawshank Redemption',
    posterPath:
        'https://image.tmdb.org/t/p/w500/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg',
    rating: 9.3,
    releaseDate: '1994',
    genres: ['Drama'],
    runtime: 142,
    overview:
        'Two imprisoned men bond over a number of years, finding comfort and eventual redemption through acts of common decency.',
  ),
  Movie(
    id: 5,
    title: 'The Godfather',
    posterPath:
        'https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
    rating: 9.2,
    releaseDate: '1972',
    genres: ['Drama', 'Crime'],
    runtime: 175,
    overview:
        'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
  ),
  Movie(
    id: 6,
    title: 'Pulp Fiction',
    posterPath:
        'https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg',
    rating: 8.9,
    releaseDate: '1994',
    genres: ['Crime', 'Drama'],
    runtime: 154,
    overview:
        'The lives of several characters become intertwined in a series of violent and unexpected events.',
  ),
];

const List<Movie> allMovies = [...popularMovies, ...topRatedMovies];
