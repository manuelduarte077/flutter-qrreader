import 'package:flutter/material.dart';
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
        //     '#ff6666', 'Cancel', false, ScanMode.DEFAULT);

        const String barcodeScanRes = "https://www.getnerdify.com";

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.nuevoScan(barcodeScanRes);

        scanListProvider.nuevoScan("geo:40.730610,-73.935242");
        scanListProvider.nuevoScan("http://www.google.com");

        print(barcodeScanRes);
      },
    );
  }
}
