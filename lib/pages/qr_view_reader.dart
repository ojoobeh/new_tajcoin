
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:webazin/utils/utils.dart';

class QRViewReader extends StatefulWidget {
  const QRViewReader({Key? key}) : super(key: key);

  @override
  _QRViewReaderState createState() => _QRViewReaderState();
}

class _QRViewReaderState extends State<QRViewReader> {
  GlobalKey qrKey = GlobalKey();
  var qrText = '';
  QRViewController? qrViewController;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Center(
              child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.green, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                      margin: const EdgeInsets.all(8),
                      child: QRView(
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }
  bool isBack=false;
  void _onQRViewCreated(QRViewController _qrViewController) {
    this.qrViewController = _qrViewController;
    qrViewController!.scannedDataStream.listen((event) {
      if(!isBack){

        Get.back(result: event.code.toString());
        isBack=true;
      }
    });
  }
}
