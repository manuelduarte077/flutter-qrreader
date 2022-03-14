import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/provider/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  // Crear nuevo Scan
  nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    // Asingar el ID de la base de datos al modelo
    nuevoScan.id = id;

    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }
  }

  // Cargar Scans de la base de datos
  cargarScans() async {
    final List<ScanModel> temp = await DBProvider.db.getAllScans();
    scans = temp;
    notifyListeners();
  }

  // Caragar Scans por tipo
  cargarScansPorTipo(String tipo) async {
    tipoSeleccionado = tipo;
    final List<ScanModel> temp = await DBProvider.db.getScansByType(tipo);
    scans = temp.where((s) => s.tipo == tipo).toList();
    notifyListeners();
  }

  // Borrar todos los Scans
  borrarTodos() async {
    DBProvider.db.deleteAll;
    scans = [];
    notifyListeners();
    print('Borrar todos');
  }

  // Borrar un Scan
  borrarScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    scans = scans.where((s) => s.id != id).toList();
    notifyListeners();
  }
}
