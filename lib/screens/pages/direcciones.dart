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
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (DismissDirection direction) {
            Provider.of<ScanListProvider>(context, listen: false)
                .borrarScanById(scans[index].id!);
          },
          child: ListTile(
            title: Text(scans[index].valor),
            subtitle: Text('ID: ${scans[index].id}'),
            leading: Icon(Icons.home_outlined,
                color: Theme.of(context).primaryColor),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
            onTap: () {
              print(scans[index].id);
            },
          ),
        );
      },
    );
  }
}
