import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/provider.dart';
import 'package:qr_scanner/screens/widgets/widgets.dart';
import 'package:qr_scanner/shared/theme_preferences.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = 'Setting';
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Settings'),
      ),
      drawer: const SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Theme',
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            SwitchListTile.adaptive(
              title: const Text('Dark Mode'),
              value: ThemePreferences.isDarkMode,
              onChanged: (value) {
                ThemePreferences.isDarkMode = value;
                final themeProvider =
                    Provider.of<ThemeProvider>(context, listen: false);

                value
                    ? themeProvider.setDarkMode()
                    : themeProvider.setLightMode();

                setState(() {});
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
