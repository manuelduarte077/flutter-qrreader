import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';
import 'package:qr_scanner/utils/utils.dart';

class CustomScanner extends StatelessWidget {
  const CustomScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.qr_code_scanner),
      onPressed: () async {
        String barrcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666',
          'Cancel',
          true,
          ScanMode.DEFAULT,
        );

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        if (barrcodeScanRes == '-1') {
          return;
        }
        final nuevoScan = await scanListProvider.nuevoScan(barrcodeScanRes);

        launchURL(context, nuevoScan);
      },
    );
  }
}
