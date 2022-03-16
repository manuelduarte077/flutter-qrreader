import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor;

   // Abir el sitio web
  if (scan.tipo == 'http') {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } else  if (scan.tipo == 'geo') {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  } else {
    Navigator.pushNamed(context, 'scan_image', arguments: scan);
  }

  // TODO: Hacer switch para abrir en otra pantalla


}
