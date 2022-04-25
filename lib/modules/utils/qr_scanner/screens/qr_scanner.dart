import 'dart:async';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/configs/themes/color_palette.dart';
import 'package:botp_auth/constants/common.dart';
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
      QRScannerFunctionalityOverlay(
        cameraController: cameraController,
        opacity: 0.6,
        size: 350,
      ),
    ]));
  }
}

class QRScannerFunctionalityOverlay extends StatefulWidget {
  final MobileScannerController cameraController;
  final double opacity;
  final double size;
  final double outerOffset = 10;
  final int reverseMilliseconds = 1500;
  final Color color = ColorPalette.black;

  const QRScannerFunctionalityOverlay({
    Key? key,
    required this.cameraController,
    required this.opacity,
    required this.size,
  }) : super(key: key);

  @override
  State<QRScannerFunctionalityOverlay> createState() =>
      _QRScannerFunctionalityOverlayState();
}

class _QRScannerFunctionalityOverlayState
    extends State<QRScannerFunctionalityOverlay> {
  late Timer _qrBoxBarTimer;
  bool? _qrBoxBarHitTop;
  @override
  void initState() {
    super.initState();
    // Run method on Widget build completed: https://stackoverflow.com/questions/49466556/flutter-run-method-on-widget-build-complete
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      switchQrBoxBarHitTop();
      setupSwitchQrBoxBarHitTopTimer();
    });
  }

  void setupSwitchQrBoxBarHitTopTimer() {
    _qrBoxBarTimer = Timer.periodic(
        Duration(milliseconds: widget.reverseMilliseconds), (Timer timer) {
      switchQrBoxBarHitTop();
    });
  }

  void switchQrBoxBarHitTop() {
    setState(() {
      if (_qrBoxBarHitTop == null) {
        _qrBoxBarHitTop = false;
      } else {
        _qrBoxBarHitTop = !_qrBoxBarHitTop!;
      }
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
    // final qrBoxPaddingBottom = widget.size / 4;
    final qrBoxSize = widget.size;
    final qrBorderBoxSize = widget.size + widget.outerOffset;
    final qrBoxBarSize = widget.size - widget.outerOffset;

    return Stack(children: [
      Stack(children: [
        // QR Background overlay
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: (height - qrBoxSize) / 2,
              color: overlayColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: qrBoxSize,
                  width: (width - qrBoxSize) / 2,
                  color: overlayColor,
                ),
                Container(
                  height: qrBoxSize,
                  width: (width - qrBoxSize) / 2,
                  color: overlayColor,
                ),
              ],
            ),
            Container(
              height: (height - qrBoxSize) / 2,
              color: overlayColor,
            ),
          ],
        ),
        // Text and gallery button
        Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: kAppPaddingBetweenItemLargeSize),
          Text("Place your QR code inside this box",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: ColorPalette.gray50)),
          SizedBox(
              width: widget.size,
              height: widget.size + 2 * kAppPaddingBetweenItemLargeSize),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ButtonNormalWidget(
              text: "Choose from gallery",
              onPressed: () {},
              size: ButtonNormalSize.normal,
            )
          ]),
        ])),
        // Navigate and flash button
        SizedBox(
            width: width,
            height: 56,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Application.router.pop(context); // Null qr result
                          },
                          color: ColorPalette.gray50),
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: widget.cameraController.torchState,
                          builder: (context, state, child) {
                            switch (state as TorchState) {
                              case TorchState.off:
                                return const Icon(Icons.flash_off,
                                    color: ColorPalette.gray50);
                              case TorchState.on:
                                return const Icon(Icons.flash_on,
                                    color: ColorPalette.blue400);
                            }
                          },
                        ),
                        iconSize: 24.0,
                        onPressed: () => widget.cameraController.toggleTorch(),
                      ),
                    ]))),
        // QR Box Border
        Center(
            child: CustomPaint(
          foregroundPainter: QRBoxBorderPainter(),
          child: SizedBox(
            width: qrBorderBoxSize,
            height: qrBorderBoxSize,
          ),
        )),
        // QR Box Bar
        Center(
            child: SizedBox(
          width: qrBoxBarSize,
          height: qrBoxBarSize,
          child: Stack(children: [
            AnimatedPositioned(
                width: qrBoxBarSize,
                duration: Duration(milliseconds: widget.reverseMilliseconds),
                curve: Curves.easeInOut,
                top: _qrBoxBarHitTop == null
                    ? 0
                    : _qrBoxBarHitTop == true
                        ? 0
                        : qrBoxBarSize - 2,
                child: const Divider(
                  height: 2,
                  thickness: 2,
                  color: ColorPalette.blue400,
                ))
          ]),
        ))
      ]),
    ]);
  }
}

class QRBoxBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height;
    double sw = size.width;
    double cornerSide = sh / 50; // desirable value for corners side
    double extendedCornerSide = sh / 10;

    Paint paint = Paint()
      ..color = ColorPalette.gray50
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
  bool shouldRepaint(QRBoxBorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(QRBoxBorderPainter oldDelegate) => false;
}
