
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/utils.dart';

class QRViewReader extends StatefulWidget {
  const QRViewReader({Key? key}) : super(key: key);

  @override
  _QRViewReaderState createState() => _QRViewReaderState();
}

class _QRViewReaderState extends State<QRViewReader> {
  GlobalKey qrKey = GlobalKey();
  var qrText = '';

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
                     )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
  bool isBack=false;
}
