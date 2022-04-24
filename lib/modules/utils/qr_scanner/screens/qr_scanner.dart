import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();

  String qrText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Mobile Scanner'),
        //   actions: [
        //     IconButton(
        //       color: Colors.white,
        //       icon: ValueListenableBuilder(
        //         valueListenable: cameraController.torchState,
        //         builder: (context, state, child) {
        //           switch (state as TorchState) {
        //             case TorchState.off:
        //               return const Icon(Icons.flash_off, color: Colors.grey);
        //             case TorchState.on:
        //               return const Icon(Icons.flash_on, color: Colors.yellow);
        //           }
        //         },
        //       ),
        //       iconSize: 32.0,
        //       onPressed: () => cameraController.toggleTorch(),
        //     ),
        //     IconButton(
        //       color: Colors.white,
        //       icon: ValueListenableBuilder(
        //         valueListenable: cameraController.cameraFacingState,
        //         builder: (context, state, child) {
        //           switch (state as CameraFacing) {
        //             case CameraFacing.front:
        //               return const Icon(Icons.camera_front);
        //             case CameraFacing.back:
        //               return const Icon(Icons.camera_rear);
        //           }
        //         },
        //       ),
        //       iconSize: 32.0,
        //       onPressed: () => cameraController.switchCamera(),
        //     ),
        //   ],
        // ),
        body: Stack(children: [
      MobileScanner(
          allowDuplicates: false,
          controller: cameraController,
          onDetect: (barcode, args) {
            setState(() {
              qrText = barcode.rawValue ?? "nothing";
            });
          }),
      const QRScannerOverlay(),
      Center(
          child: Container(
              child: Text("Bar code is: $qrText",
                  style: TextStyle(color: Colors.white)))),
      ButtonNormalWidget(
          text: "Cancel",
          onPressed: () {
            Application.router.pop(context);
          })
    ]));
  }
}

class QRScannerOverlay extends StatefulWidget {
  final double opacity;
  final double size;
  final Color color = Colors.black;

  const QRScannerOverlay({Key? key, this.opacity = 0.5, this.size = 240})
      : super(key: key);

  @override
  State<QRScannerOverlay> createState() => _QRScannerOverlayState();
}

class _QRScannerOverlayState extends State<QRScannerOverlay> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final overlayColor = widget.color.withOpacity(widget.opacity);
    final centerBoxSize = widget.size;
    return Container(
        width: width,
        height: height,
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: (height - centerBoxSize) / 2,
                color: overlayColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: centerBoxSize,
                    width: (width - centerBoxSize) / 2,
                    color: overlayColor,
                  ),
                  Container(
                    height: centerBoxSize,
                    width: (width - centerBoxSize) / 2,
                    color: overlayColor,
                  ),
                ],
              ),
              Container(
                height: (height - centerBoxSize) / 2,
                color: overlayColor,
              ),
            ],
          ),
          Center(
              child: CustomPaint(
            foregroundPainter: BorderPainter(),
            child: SizedBox(
              width: widget.size + 50,
              height: widget.size + 50,
            ),
          ))
        ]));
  }
}

// Custom paint: https://stackoverflow.com/questions/66579202/border-at-corner-only-in-flutter
// Corner: https://viblo.asia/p/flutter-custompaint-phan-2-3P0lP0RPlox
class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height;
    double sw = size.width;
    double cornerSide = sh * 0.15; // desirable value for corners side

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}
