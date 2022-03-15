import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';

class ScanImage extends StatelessWidget {
  const ScanImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final scan = ModalRoute.of(context)!.settings.arguments as ScanModel;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Image'),
      ),
      body: Center(
        child: Text(scan.valor),
      ),
    );
  }
}
