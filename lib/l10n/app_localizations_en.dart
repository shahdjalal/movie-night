// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Store';

  @override
  String get name => 'Name';

  @override
  String get nameDesc => 'Enter your Name';

  @override
  String get email => 'Email';

  @override
  String get emailDesc => 'Enter your email';

  @override
  String get phone => 'Phone';

  @override
  String get phoneDecs => 'Enter your Phone';

  @override
  String get password => 'Password';

  @override
  String get passwordDesc => 'Enter your password ';

  @override
  String get passwordConfirm => 'Password Confirmation';

  @override
  String get passwordConfirmDesc => 'Enter your password again';

  @override
  String get required => 'This field  is required';

  @override
  String get length => 'Name must not be less than 3 characters';

  @override
  String get validEmail => 'Please enter a valid email address';

  @override
  String get match => 'Passwords do not match';

  @override
  String get login => 'Sign Up';

  @override
  String welcome(Object name) {
    return 'Welcome $name';
  }
}
