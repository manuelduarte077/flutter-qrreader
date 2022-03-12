import 'package:flutter/material.dart';
import 'package:qr_scanner/screens/pages/home_page.dart';
import 'package:qr_scanner/screens/pages/mapa_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomePage(),
        'mapa': (context) => const MapaPage(),
      },
    );
  }
}
