import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/watchlist_screen.dart';
import 'screens/settings_screen.dart';
import 'services/movie_lists_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MovieListsService.instance.load();

  runApp(const MovieNightApp());
}

class MovieNightApp extends StatefulWidget {
  const MovieNightApp({super.key});

  @override
  State<MovieNightApp> createState() => _MovieNightAppState();
}

class _MovieNightAppState extends State<MovieNightApp> {
  bool darkMode = true;
  Locale locale = const Locale('en');

  void changeLanguage(Locale newLocale) {
    setState(() {
      locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,

      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,

      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F0F14),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F0F14),
          elevation: 0,
        ),
      ),

      home: MainScreen(
        darkMode: darkMode,
        onDarkModeChanged: (value) {
          setState(() {
            darkMode = value;
          });
        },
        locale: locale,
        onLocaleChanged: changeLanguage,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onDarkModeChanged;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  const MainScreen({
    super.key,
    required this.darkMode,
    required this.onDarkModeChanged,
    required this.locale,
    required this.onLocaleChanged,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final screens = <Widget>[
      const HomeScreen(),
      const SearchScreen(),
      const FavoritesScreen(),
      const WatchlistScreen(),
      SettingsScreen(
        darkMode: widget.darkMode,
        onDarkModeChanged: widget.onDarkModeChanged,
        locale: widget.locale,
        onLocaleChanged: widget.onLocaleChanged,
      ),
    ];

    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.search_outlined),
            selectedIcon: const Icon(Icons.search),
            label: l10n.search,
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_border),
            selectedIcon: const Icon(Icons.favorite),
            label: l10n.favorites,
          ),
          NavigationDestination(
            icon: const Icon(Icons.bookmark_border),
            selectedIcon: const Icon(Icons.bookmark),
            label: l10n.watchlist,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.settings,
          ),
        ],
      ),
    );
  }
}
