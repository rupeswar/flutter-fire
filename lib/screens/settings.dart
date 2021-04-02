import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/utils/theme_notifier.dart';
import 'package:flutter_fire/values/theme.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themenotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themenotifier.getTheme() == darkTheme);
    ThemeData theme = themenotifier.getTheme();

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Dark Theme',
              style: TextStyle(
                color: theme.accentColor,
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 16.0),
            trailing: Transform.scale(
              scale: 0.4,
              child: DayNightSwitcher(
                isDarkModeEnabled: _darkTheme,
                onStateChanged: (val) {
                  setState(() {
                    _darkTheme = val;
                  });
                  onThemeChanged(val, themenotifier);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void onThemeChanged(bool isDarkTheme, ThemeNotifier themenotifier) {
  if (isDarkTheme)
    themenotifier.setTheme(darkTheme);
  else
    themenotifier.setTheme(lightTheme);
}
