import 'package:flutter/material.dart';
import 'package:qr_scanner/screens/widgets/widgets.dart';

class MapasPage extends StatelessWidget {
  const MapasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanType(tipo: 'geo');
  }
}
