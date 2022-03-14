import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';

class DireccionesPage extends StatelessWidget {
  const DireccionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(scans[index].valor),
          leading: Icon(Icons.map, color: Theme.of(context).primaryColor),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () {
            print(scans[index].id);
          },
        );
      },
    );
  }
}
