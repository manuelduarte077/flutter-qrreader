import 'package:flutter/material.dart';
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
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //   '#ff6666',
        //   'Cancel',
        //   false,
        //   ScanMode.DEFAULT,
        // );

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        const barraCodes = 'geo:45.23,-75.92';

        if (barraCodes == '-1') {
          return;
        }
        final nuevoScan = await scanListProvider.nuevoScan(barraCodes);

        launchURL(context, nuevoScan);

        print("No sirve: " + nuevoScan.toString());
      },
    );
  }
}
