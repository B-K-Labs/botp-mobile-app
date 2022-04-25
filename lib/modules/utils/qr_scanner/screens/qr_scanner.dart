import 'dart:async';
import 'dart:math';
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Application.router.pop(context); // Null qr result
              },
              color: ColorPalette.gray50),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
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
              onPressed: () => cameraController.toggleTorch(),
            )
          ],
        ),
        body: Stack(children: [
          MobileScanner(
              allowDuplicates: false,
              controller: cameraController,
              onDetect: (barcode, args) {
                // Return rawValue directly
                Application.router.pop(context, barcode.rawValue);
              }),
          const QRScannerFunctionalityOverlay(
            ratio: 0.8,
            opacity: 0.6,
          ),
        ]));
  }
}

class QRScannerFunctionalityOverlay extends StatefulWidget {
  final double opacity;
  final double ratio;
  final double outerOffset = 10;
  final int reverseMilliseconds = 1500;
  final Color color = ColorPalette.black;

  const QRScannerFunctionalityOverlay({
    Key? key,
    required this.ratio,
    required this.opacity,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final overlayColor = widget.color.withOpacity(widget.opacity);
    // Get the appropriate size
    final qrBoxSize =
        min(screenWidth, screenHeight - 4 * kAppPaddingBetweenItemLargeSize) *
                widget.ratio -
            widget.outerOffset;
    final qrBorderBoxSize = qrBoxSize + widget.outerOffset;
    final qrBarBoxSize = qrBoxSize - widget.outerOffset;

    return Stack(children: [
      Stack(children: [
        // QR Background overlay
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: (screenHeight - qrBoxSize) / 2,
              color: overlayColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: qrBoxSize,
                  width: (screenWidth - qrBoxSize) / 2,
                  color: overlayColor,
                ),
                Container(
                  height: qrBoxSize,
                  width: (screenWidth - qrBoxSize) / 2,
                  color: overlayColor,
                ),
              ],
            ),
            Container(
              height: (screenHeight - qrBoxSize) / 2,
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
              width: qrBoxSize,
              height: qrBoxSize + 2 * kAppPaddingBetweenItemLargeSize),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ButtonNormalWidget(
              text: "Choose from gallery",
              onPressed: () {},
              size: ButtonNormalSize.normal,
            )
          ]),
        ])),
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
          width: qrBarBoxSize,
          height: qrBarBoxSize,
          child: Stack(children: [
            AnimatedPositioned(
                width: qrBarBoxSize,
                duration: Duration(milliseconds: widget.reverseMilliseconds),
                curve: Curves.easeInOut,
                top: _qrBoxBarHitTop == null
                    ? 0
                    : _qrBoxBarHitTop == true
                        ? 0
                        : qrBarBoxSize - 2,
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
