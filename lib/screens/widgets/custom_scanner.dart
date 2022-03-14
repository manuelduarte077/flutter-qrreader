import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';

class CustomScanner extends StatelessWidget {
  const CustomScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.qr_code_scanner),
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //   '#ff6666',
        //   'Cancel',
        //   false,
        //   ScanMode.DEFAULT,
        // );

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        scanListProvider.nuevoScan("http://www.getnerdify.com");

        scanListProvider.nuevoScan("geo:40.730610,-73.935242");

        print("No sirve: " + scanListProvider.toString());
      },
    );
  }
}
