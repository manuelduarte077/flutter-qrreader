import 'package:flutter/material.dart';

import 'package:qr_scanner/screens/pages/scan/qr_code_scanner_screen.dart';

class CustomScanner extends StatelessWidget {
  const CustomScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const QRCodeScannerScreen(),
          ),
        );
        // final scanListProvider =
        //     Provider.of<ScanListProvider>(context, listen: false);

        // if (QRCodeScannerScreen == '-1') {
        //   return;
        // }
        // final nuevoScan = await scanListProvider
        //     .nuevoScan(QRCodeScannerScreen().toString());

        // launchURL(context, nuevoScan);
      },
      child: const Icon(Icons.qr_code_scanner_rounded),
      tooltip: 'Scan QR Code',
    );
  }
}
