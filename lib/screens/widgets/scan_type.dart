import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/provider.dart';
import 'package:qr_scanner/utils/utils.dart';

class ScanType extends StatelessWidget {
  final String tipo;
  const ScanType({
    Key? key,
    required this.tipo,
  }) : super(key: key);

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
            DBProvider.db.deleteScan(scans[index].id!);
          },
          child: ListTile(
            title: Text(scans[index].valor),
            subtitle: Text('ID: ${scans[index].id}'),
            leading: Icon(
              tipo == 'http' ? Icons.home_outlined : Icons.map,
              color: tipo == 'http' ? Colors.deepPurple : Colors.deepPurple,
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              launchURL(context, scans[index]);
            },
          ),
        );
      },
    );
  }
}
