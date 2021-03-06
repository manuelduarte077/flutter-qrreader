import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';
import 'package:qr_scanner/utils/constants.dart';
import 'package:qr_scanner/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:another_flushbar/flushbar.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScannerScreen> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _qrViewController;
  String _qrString = '';
  bool _flashIsOn = false;

  bool _isBeingProcessed = false;
  Flushbar? _flush;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          var scanArea =
              (constraints.maxWidth < 400 || constraints.maxHeight < 400)
                  ? 180.0
                  : 300.0;

          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: yellowColor,
                    borderRadius: 4,
                    borderLength: 30,
                    cutOutSize: scanArea,
                  ),
                ),
              ),
              Positioned(
                top: screenSize.height * .1,
                child: Container(
                  margin: const EdgeInsets.only(top: 80, left: 15, right: 15),
                  child: const Text(
                    'Move the camera to QR code to scan',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                top: screenSize.height * .05,
                left: 15,
                child: closeQRScannerButton(context),
              ),
              Positioned(
                top: screenSize.height * .05,
                right: 15,
                child: cameraSwitchButton(),
              ),
              Positioned(
                bottom: screenSize.height * .15,
                child: Column(
                  children: [
                    toggleFlashButton(),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      'Press to ${_flashIsOn ? 'off' : 'open'} the flash',
                      style: const TextStyle(color: whiteColor),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget toggleFlashButton() {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          _flashIsOn = !_flashIsOn;
        });
        await _qrViewController!.toggleFlash();
      },
      child: Icon(
        Icons.flash_on_outlined,
        color: _flashIsOn ? yellowColor : whiteColor,
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: whiteColor.withOpacity(.3),
        padding: const EdgeInsets.all(14),
      ),
    );
  }

  // El botton para cerrar el scanner

  Widget closeQRScannerButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Icon(Icons.clear_rounded),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: whiteColor.withOpacity(.3),
      ),
    );
  }

// Pasa pasar la camara, a camara frontal
  Widget cameraSwitchButton() {
    return ElevatedButton(
      onPressed: () async {
        await _qrViewController!.flipCamera();
      },
      child: const Icon(Icons.cameraswitch_rounded),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: whiteColor.withOpacity(.3),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrViewController = controller;
    _qrViewController!.scannedDataStream.listen(
      (scanData) async {
        if (_qrString != scanData.code) {
          _isBeingProcessed = false;
          _qrString = scanData.code!;
        } else {
          return;
        }

        if (_isBeingProcessed == false) {
          if (_flush != null) {
            _flush!.dismiss();
          }
          if (await canLaunch(scanData.code!)) {
            await _qrViewController!.pauseCamera();
            setState(() {
              if (_flashIsOn) {
                _flashIsOn = !_flashIsOn;
                _qrViewController!.toggleFlash();
              }
            });
            await launch(scanData.code!);
            _qrViewController!.resumeCamera();
            _qrString = '';
          } else {
            _flush = buildFlushbar(scanData);
            _flush!.show(context);
          }
        }
        print('QR: ${scanData.code}');
        print(scanData.code!);

        // TODO: Guardar en la base de datos el codigo qr

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        if (scanData.code! == '-1') {
          return;
        }

        final nuevoScan = await scanListProvider.nuevoScan(scanData.code!);

        launchURL(context, nuevoScan);
      },
    );
  }

  // Flushbar para mostrar el contenido del qr y poder copiarlo

  Flushbar buildFlushbar(Barcode scanData) {
    return Flushbar(
      backgroundColor: whiteColor,
      flushbarPosition: FlushbarPosition.TOP,
      title: 'Content',
      titleColor: blackColor,
      messageText: Text(
        scanData.code!,
        style: const TextStyle(
          fontSize: 14,
          color: blackColor,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: 2,
      ),
      messageColor: blackColor,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(10),
      mainButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        ),
        child: Text(
          'Copy',
          style: titleStyle.copyWith(fontSize: 16),
        ),
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: scanData.code!));
          _flush!.dismiss();
        },
      ),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      onStatusChanged: (status) {
        switch (status) {
          case FlushbarStatus.DISMISSED:
            //* Yeah? Successful logic processing
            if (_isBeingProcessed == true) {
              _qrString = '';
            }
            _isBeingProcessed = false;
            break;
          case FlushbarStatus.SHOWING:
            _isBeingProcessed = true;
            break;
          default:
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _qrViewController?.dispose();
  }
}
