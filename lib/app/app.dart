import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/provider.dart';
import 'package:qr_scanner/screens/pages/pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).currentTheme,
        initialRoute: 'home',
        routes: {
          'home': (context) => const HomePage(),
          'mapa': (context) => const MapaPage(),
          'mapas': (context) => const MapasPage(),
          'scan_image': (context) => const ScanImage(),
          'image_scan': (context) => const ImageScan(),
          'settings': (context) => const SettingScreen(),
        },
      ),
    );
  }
}
