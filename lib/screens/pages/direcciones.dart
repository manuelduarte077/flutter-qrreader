import 'package:flutter/material.dart';

import 'package:qr_scanner/screens/widgets/scan_type.dart';

class DireccionesPage extends StatelessWidget {
  const DireccionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanType(tipo: "geo");
  }
}
