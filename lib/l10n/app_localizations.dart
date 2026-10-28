import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Movie Night'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @watchlist.
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get watchlist;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @darkModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Use dark theme throughout the app'**
  String get darkModeDescription;

  /// No description provided for @languageSection.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSection;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover your next favorite movie'**
  String get aboutDescription;

  /// No description provided for @searchMovies.
  ///
  /// In en, this message translates to:
  /// **'Search Movies'**
  String get searchMovies;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a movie...'**
  String get searchHint;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @drama.
  ///
  /// In en, this message translates to:
  /// **'Drama'**
  String get drama;

  /// No description provided for @crime.
  ///
  /// In en, this message translates to:
  /// **'Crime'**
  String get crime;

  /// No description provided for @sciFi.
  ///
  /// In en, this message translates to:
  /// **'Sci-Fi'**
  String get sciFi;

  /// No description provided for @adventure.
  ///
  /// In en, this message translates to:
  /// **'Adventure'**
  String get adventure;

  /// No description provided for @pickAMovie.
  ///
  /// In en, this message translates to:
  /// **'Pick a Movie'**
  String get pickAMovie;

  /// No description provided for @whatToWatch.
  ///
  /// In en, this message translates to:
  /// **'What do you feel like watching?'**
  String get whatToWatch;

  /// No description provided for @chooseGenrePrompt.
  ///
  /// In en, this message translates to:
  /// **'Choose a genre and let us pick!'**
  String get chooseGenrePrompt;

  /// No description provided for @findingMovie.
  ///
  /// In en, this message translates to:
  /// **'Finding a movie...'**
  String get findingMovie;

  /// No description provided for @noMoviesFound.
  ///
  /// In en, this message translates to:
  /// **'No movies found 🎬'**
  String get noMoviesFound;

  /// No description provided for @enterAtLeastTwoCharacters.
  ///
  /// In en, this message translates to:
  /// **'Enter at least 2 characters'**
  String get enterAtLeastTwoCharacters;

  /// No description provided for @couldNotLoadMovies.
  ///
  /// In en, this message translates to:
  /// **'Could not load movies. Check your connection and try again.'**
  String get couldNotLoadMovies;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @noPopularMoviesForGenre.
  ///
  /// In en, this message translates to:
  /// **'No popular movies found for this genre. Try another genre.'**
  String get noPopularMoviesForGenre;

  /// No description provided for @connectionAndTokenError.
  ///
  /// In en, this message translates to:
  /// **'Could not load movies. Check your connection and TMDB token.'**
  String get connectionAndTokenError;

  /// No description provided for @findNextMovie.
  ///
  /// In en, this message translates to:
  /// **'Find your next movie 🍿'**
  String get findNextMovie;

  /// No description provided for @discoverSomethingYouWillLove.
  ///
  /// In en, this message translates to:
  /// **'Discover something you will love.'**
  String get discoverSomethingYouWillLove;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// No description provided for @topRated.
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get topRated;

  /// No description provided for @failedToLoadMovies.
  ///
  /// In en, this message translates to:
  /// **'Failed to load movies'**
  String get failedToLoadMovies;

  /// No description provided for @cantDecide.
  ///
  /// In en, this message translates to:
  /// **'Can’t decide?'**
  String get cantDecide;

  /// No description provided for @letUsPickMovie.
  ///
  /// In en, this message translates to:
  /// **'Let us pick a movie for you!'**
  String get letUsPickMovie;

  /// No description provided for @noFavoriteMoviesYet.
  ///
  /// In en, this message translates to:
  /// **'No favorite movies yet'**
  String get noFavoriteMoviesYet;

  /// No description provided for @addMoviesFromDetailsPage.
  ///
  /// In en, this message translates to:
  /// **'Add movies from their details page'**
  String get addMoviesFromDetailsPage;

  /// No description provided for @yourWatchlistIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your watchlist is empty'**
  String get yourWatchlistIsEmpty;

  /// No description provided for @addMoviesYouWantToWatch.
  ///
  /// In en, this message translates to:
  /// **'Add movies you want to watch'**
  String get addMoviesYouWantToWatch;

  /// No description provided for @couldNotLoadMovieDetails.
  ///
  /// In en, this message translates to:
  /// **'Could not load movie details.'**
  String get couldNotLoadMovieDetails;

  /// No description provided for @releaseDateUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Release date unavailable'**
  String get releaseDateUnavailable;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @noOverviewAvailable.
  ///
  /// In en, this message translates to:
  /// **'No overview available.'**
  String get noOverviewAvailable;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @favorited.
  ///
  /// In en, this message translates to:
  /// **'Favorited'**
  String get favorited;

  /// No description provided for @inWatchlist.
  ///
  /// In en, this message translates to:
  /// **'In Watchlist'**
  String get inWatchlist;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minutes;

  /// No description provided for @animation.
  ///
  /// In en, this message translates to:
  /// **'Animation'**
  String get animation;

  /// No description provided for @comedy.
  ///
  /// In en, this message translates to:
  /// **'Comedy'**
  String get comedy;

  /// No description provided for @documentary.
  ///
  /// In en, this message translates to:
  /// **'Documentary'**
  String get documentary;

  /// No description provided for @family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family;

  /// No description provided for @fantasy.
  ///
  /// In en, this message translates to:
  /// **'Fantasy'**
  String get fantasy;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @horror.
  ///
  /// In en, this message translates to:
  /// **'Horror'**
  String get horror;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @mystery.
  ///
  /// In en, this message translates to:
  /// **'Mystery'**
  String get mystery;

  /// No description provided for @romance.
  ///
  /// In en, this message translates to:
  /// **'Romance'**
  String get romance;

  /// No description provided for @tvMovie.
  ///
  /// In en, this message translates to:
  /// **'TV Movie'**
  String get tvMovie;

  /// No description provided for @thriller.
  ///
  /// In en, this message translates to:
  /// **'Thriller'**
  String get thriller;

  /// No description provided for @war.
  ///
  /// In en, this message translates to:
  /// **'War'**
  String get war;

  /// No description provided for @western.
  ///
  /// In en, this message translates to:
  /// **'Western'**
  String get western;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
