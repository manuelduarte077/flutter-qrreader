import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/provider/db_provider.dart';
import 'package:qr_scanner/provider/ui_provider.dart';
import 'package:qr_scanner/screens/pages/direcciones.dart';
import 'package:qr_scanner/screens/pages/mapas_page.dart';
import 'package:qr_scanner/screens/widgets/custom_navigationbar.dart';
import 'package:qr_scanner/screens/widgets/custom_scanner.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {},
          ),
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const CustomScanner(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el seleccionado menu de la navegacion
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    DBProvider.db.getScansByType('geo').then((scans) {
      print("Tipo: " + scans.toString());
    });

    switch (currentIndex) {
      case 0:
        return const MapasPage();
      case 1:
        return const DireccionesPage();
      default:
        return const MapasPage();
    }
  }
}
