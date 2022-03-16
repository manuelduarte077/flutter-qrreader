import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/provider.dart';
import 'package:qr_scanner/shared/theme_preferences.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ThemePreferences.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              ThemeProvider(isDarkMode: ThemePreferences.isDarkMode),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
