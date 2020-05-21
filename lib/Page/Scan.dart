import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wangyiyun/Mobx/Counter.dart';

class Scan extends StatefulWidget {
  Scan({Key key}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  String qrText = '';
  void _onQRViewCreated(QRViewController controller) async{
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if(qrText.length == 0 ) {
          print(scanData);
          print("------");
          setState(() {
              qrText = scanData;
               Navigator.pop(context,true);
          });
      }
    });
  }

  // bool _isFlashOn(String current) {
  //   return flashOn == current;
  // }

  // bool _isBackCamera(String current) {
  //   return backCamera == current;
  // }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterState>(builder: (context, state, child) {
      return Scaffold(
        backgroundColor: state.color,
        appBar: AppBar(
          backgroundColor: state.color,
          title: Text("扫一扫"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
