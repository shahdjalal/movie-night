import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onDarkModeChanged;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  const SettingsScreen({
    super.key,
    required this.darkMode,
    required this.onDarkModeChanged,
    required this.locale,
    required this.onLocaleChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final language = widget.locale.languageCode == 'ar' ? 'Arabic' : 'English';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settings,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.appearance,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Card(
            child: SwitchListTile(
              title: Text(l10n.darkMode),
              subtitle: Text(l10n.darkModeDescription),
              secondary: const Icon(Icons.dark_mode),
              value: widget.darkMode,
              onChanged: widget.onDarkModeChanged,
            ),
          ),

          const SizedBox(height: 25),

          Text(
            l10n.languageSection,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: Text(l10n.appLanguage),
              subtitle: Text(language == 'Arabic' ? 'العربية' : 'English'),
              trailing: DropdownButton<String>(
                value: language,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: 'English', child: Text('English')),
                  DropdownMenuItem(value: 'Arabic', child: Text('العربية')),
                ],
                onChanged: (value) {
                  if (value == null) return;

                  widget.onLocaleChanged(
                    Locale(value == 'Arabic' ? 'ar' : 'en'),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 25),

          Text(
            l10n.about,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Card(
            child: ListTile(
              leading: const Icon(Icons.movie),
              title: Text(l10n.appTitle),
              subtitle: Text(l10n.aboutDescription),
            ),
          ),
        ],
      ),
    );
  }
}
