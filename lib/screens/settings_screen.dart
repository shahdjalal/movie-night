import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onDarkModeChanged;
  const SettingsScreen({
    super.key,
    required this.darkMode,
    required this.onDarkModeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Appearance',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Card(
            child: SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Use dark theme throughout the app'),
              secondary: const Icon(Icons.dark_mode),
              value: widget.darkMode,
              onChanged: widget.onDarkModeChanged,
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Language',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text('App Language'),
              subtitle: Text(language),
              trailing: DropdownButton<String>(
                value: language,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: 'English', child: Text('English')),
                  DropdownMenuItem(value: 'Arabic', child: Text('العربية')),
                ],
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    language = value;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'About',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          const Card(
            child: ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movie Night'),
              subtitle: Text('Discover your next favorite movie'),
            ),
          ),
        ],
      ),
    );
  }
}
