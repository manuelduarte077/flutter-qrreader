import 'package:flutter/material.dart';
import 'package:qr_scanner/screens/pages/home_page.dart';
import 'package:qr_scanner/screens/pages/mapa_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomePage(),
        'mapa': (context) => const MapaPage(),
      },
    );
  }
}
