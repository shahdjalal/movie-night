# 🎬 Movie Night

**Movie Night** is a Flutter application for discovering movies, exploring their details, and organizing a personal movie collection. It integrates with [The Movie Database (TMDB) API](https://www.themoviedb.org/) to retrieve real movie data.

## ✨ Features

- **Movie Discovery:** Browse popular and top-rated movies.
- **Movie Details:** Explore movie information, ratings, release dates, genres, runtime, and overview.
- **Favorites:** Save movies to a personal favorites list.
- **Watchlist:** Keep track of movies you want to watch later.
- **Local Persistence:** Favorites and watchlist items remain saved on the device using SharedPreferences.
- **Dark Theme:** A dark-themed interface designed for a comfortable movie-browsing experience.

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Programming Language:** Dart
- **Movie Data:** TMDB API
- **Local Storage:** SharedPreferences
- **UI:** Material Design

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Git](https://git-scm.com/)
- A TMDB API Read Access Token

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/YOUR-USERNAME/movie-night.git
   ```

2. Navigate to the project directory:

   ```bash
   cd movie-night
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application with your TMDB API Read Access Token:

   ```bash
   flutter run --dart-define=TMDB_TOKEN=YOUR_TMDB_READ_ACCESS_TOKEN
   ```

Replace `YOUR-USERNAME` with your GitHub username and `YOUR_TMDB_READ_ACCESS_TOKEN` with your own token.

**Security note:** Never commit your actual API token or other credentials to the repository.

## 📁 Project Structure

```text
lib/
├── l10n/
├── models/
│   ├── movie.dart
│   └── movie_data.dart
├── screens/
│   ├── home_screen.dart
│   ├── search_screen.dart
│   ├── movie_details_screen.dart
│   ├── favorites_screen.dart
│   ├── watchlist_screen.dart
│   ├── random_movie_screen.dart
│   └── settings_screen.dart
├── services/
│   ├── tmdb_service.dart
│   └── movie_lists_service.dart
├── widgets/
│   └── movie_card.dart
└── main.dart
```

## 🗺️ Roadmap

- Complete and refine movie search using the TMDB API.
- Improve loading, empty, and error states.
- Polish the user interface and overall user experience.
- Test the application across different devices and screen sizes.

## 🎞️ Movie Data Attribution

This product uses the TMDB API but is not endorsed or certified by TMDB.

Movie data and images are provided by [The Movie Database (TMDB)](https://www.themoviedb.org/).

## 👩‍💻 Author

**Shahd Marouf**

Computer Engineer

[GitHub Profile](https://github.com/shahdjalal)

---

*Built with Flutter and Dart.*
