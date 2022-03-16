import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/provider.dart';
import 'package:qr_scanner/screens/pages/pages.dart';
import 'package:qr_scanner/screens/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              DBProvider.db.deleteAll();
            },
          ),
        ],
      ),
      drawer: const SideMenu(),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const CustomScanner(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el seleccionado menu de la navegacion
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    // Usar el ScanListProvider para obtener los scans
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return const MapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return const DireccionesPage();
      case 2:
        scanListProvider.cargarScansPorTipo('image');
        return const ImageScan();
      default:
        return const MapasPage();
    }
  }
}
