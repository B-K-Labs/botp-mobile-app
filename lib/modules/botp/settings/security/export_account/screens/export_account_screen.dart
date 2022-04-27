import 'dart:io';

import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SecurityExportAccountScreen extends StatelessWidget {
  const SecurityExportAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(
        appBarTitle: "Export account", body: SecurityExportAccountBody());
  }
}

class SecurityExportAccountBody extends StatefulWidget {
  const SecurityExportAccountBody({Key? key}) : super(key: key);

  @override
  State<SecurityExportAccountBody> createState() =>
      _SecurityExportAccountBodyState();
}

class _SecurityExportAccountBodyState extends State<SecurityExportAccountBody> {
  final GlobalKey qrKey = GlobalKey(); // Assign key to QR image

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _reminder(),
        _privateKeyQr(),
        _actionButtons(),
      ],
    );
  }

  Widget _reminder() {
    final _reminderTextStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(color: Theme.of(context).colorScheme.onErrorContainer);

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kAppPaddingHorizontalSize,
          vertical: kAppPaddingVerticalSize),
      child: ReminderWidget(
          iconData: Icons.warning_rounded,
          colorType: ColorType.error,
          title: "Caution!",
          description: "Please follow these recommended rules:",
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("1. ", style: _reminderTextStyle),
                  Expanded(
                    child: Text(
                        "Be careful to display the QR code if you’re in a public place.",
                        style: _reminderTextStyle),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("2. ", style: _reminderTextStyle),
                  Expanded(
                    child: Text(
                        "Keep the QR image in external storage with encryption.",
                        style: _reminderTextStyle),
                  ),
                ],
              )
            ],
          )),
    );
  }

  Widget _privateKeyQr() {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(boxShadowOffsetX, boxShadowOffsetY),
                  blurRadius: boxShadowBlurRadius,
                  color: Theme.of(context)
                      .shadowColor
                      .withOpacity(boxShadowOpacity))
            ]),
        child: RepaintBoundary(
            key: qrKey,
            child: QrImage(
                backgroundColor: Colors.white,
                version: QrVersions.auto,
                errorCorrectionLevel: QrErrorCorrectLevel.M,
                data:
                    "fd1f00d03005178763d675ee510d398c4037f85f70c9411254996934b5a1db85",
                size: 240.0,
                gapless: false,
                embeddedImage: const AssetImage(
                    "assets/images/logo/botp_logo_embedded_qr.png"),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: const Size(60, 60),
                ))));
  }

  Widget _actionButtons() {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kAppPaddingHorizontalSize,
            vertical: kAppPaddingVerticalSize),
        child: Row(children: [
          Expanded(
              flex: 1,
              child: ButtonNormalWidget(
                text: 'Download image',
                onPressed: () async {
                  // TODO: Save image
                  await saveQrCodeToGallery();
                },
                type: ButtonNormalType.secondaryOutlined,
              )),
          const SizedBox(width: kAppPaddingBetweenItemSmallSize),
          Expanded(
              flex: 1,
              child: ButtonNormalWidget(
                  text: 'Go back',
                  onPressed: () {
                    Application.router.pop(context);
                  }))
        ]));
  }

  saveQrCodeToGallery() async {
    // PermissionStatus res;
    // res = await Permission.storage.request();
    // if (res.isGranted) {
    final boundary =
        qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    // Increase the QR image size
    final image = await boundary.toImage(pixelRatio: 5.0);
    final byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final pngBytes = byteData.buffer.asUint8List();
      // Get app document directory
      final directory = (await getApplicationDocumentsDirectory()).path;
      final imgFile = File('$directory/${DateTime.now()}.${"qr"}.png');
      imgFile.writeAsBytes(pngBytes);
      // Save image
      GallerySaver.saveImage(imgFile.path).then((success) async {
        showSnackBar(
            context, "Saved QR image successfully.", SnackBarType.success);
      }).catchError((e) {
        showSnackBar(context, "Failed to save the QR image.");
      });
      return;
    }
    showSnackBar(context, "Failed to save the QR image.");
  }
}
