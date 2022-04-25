import 'dart:async';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
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
            // Return rawValue directly
            Application.router.pop(context, barcode.rawValue);
          }),
      const QRScannerOverlay(
        opacity: 0.5,
        size: 300,
      ),
    ]));
  }
}

class QRScannerOverlay extends StatefulWidget {
  final double opacity;
  final double size;
  final double outerOffset = 20;
  final Color color = Colors.black;

  const QRScannerOverlay({
    Key? key,
    required this.opacity,
    required this.size,
  }) : super(key: key);

  @override
  State<QRScannerOverlay> createState() => _QRScannerOverlayState();
}

class _QRScannerOverlayState extends State<QRScannerOverlay> {
  late Timer _qrBoxBarTimer;
  bool _qrBoxBarHitTop = true;
  @override
  void initState() {
    super.initState();
    _qrBoxBarHitTop = false;
    _qrBoxBarTimer =
        Timer.periodic(const Duration(milliseconds: 1500), (Timer timer) {
      _qrBoxBarHitTop = !_qrBoxBarHitTop;
    });
  }

  @override
  void dispose() {
    _qrBoxBarTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final overlayColor = widget.color.withOpacity(widget.opacity);
    final centerBoxSize = widget.size;
    return Stack(children: [
      Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            width: widget.size + widget.outerOffset,
            height: widget.size + widget.outerOffset,
          ),
        ))
      ]),
      Center(
          child: Container(
              width: widget.size,
              height: widget.size,
              child: AnimatedPositioned(
                  width: widget.size,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOutCubic,
                  top: 100,
                  child: const Divider(
                    thickness: 2,
                    color: Colors.white,
                  )),
              color: Colors.red))
    ]);
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height;
    double sw = size.width;
    double cornerSide = sh / 50; // desirable value for corners side
    double extendedCornerSide = sh / 10;

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    Path path = Path()
      ..moveTo(extendedCornerSide, 0)
      ..lineTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..lineTo(0, extendedCornerSide)
      ..moveTo(0, sh - extendedCornerSide)
      ..lineTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..lineTo(extendedCornerSide, sh)
      ..moveTo(sw - extendedCornerSide, sh)
      ..lineTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..lineTo(sw, sh - extendedCornerSide)
      ..moveTo(sw, extendedCornerSide)
      ..lineTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0)
      ..lineTo(sw - extendedCornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}
