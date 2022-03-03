import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _key = GlobalKey();
  QRViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text('Qr Scanner'),
        ),
      ),
      body: bodyContainer(),
    );
  }

  Widget bodyContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: QRView(key: _key, onQRViewCreated: _scanData),
        ),
        // : const SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _controller?.resumeCamera();
                  },
                  child: Text('Scan Qr')),
              ElevatedButton(
                  onPressed: () {
                    _controller?.resumeCamera();
                  },
                  child: Text('Scan BarCode'))
            ],
          ),
        ),
      ],
    );
  }

  dynamic _scanData(controller) {
    _controller = controller;
    _controller?.pauseCamera();
    _controller?.scannedDataStream.listen((event) {
      debugPrint(event.code);
      _controller?.pauseCamera();
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content:
                    Text(event.code ?? 'Something went wrong,Please try again'),
              ));
    });
  }
}
