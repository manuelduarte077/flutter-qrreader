import 'package:flutter/material.dart';

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

        String barcodeScanRes = "Manuel Duarte";

        print("Este es el resultado" + barcodeScanRes);
      },
    );
  }
}
