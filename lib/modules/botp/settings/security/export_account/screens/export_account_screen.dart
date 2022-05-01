import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/botp/settings/security/export_account/cubit/export_account_cubit.dart';
import 'package:botp_auth/modules/botp/settings/security/export_account/cubit/export_account_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider<SecurityExportAccountCubit>(
        create: (context) => SecurityExportAccountCubit(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _privateKeyQr(),
            Column(children: [
              _reminder(),
              _actionButtons(),
            ])
          ],
        ));
  }

  Widget _reminder() {
    final _reminderTextStyle = Theme.of(context)
        .textTheme
        .caption
        ?.copyWith(color: Theme.of(context).colorScheme.onErrorContainer);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kAppPaddingHorizontalSize,
      ),
      child: ReminderWidget(
          iconData: Icons.warning_rounded,
          colorType: ColorType.error,
          title: "Caution!",
          description: "To keep you safe",
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("1. ", style: _reminderTextStyle),
                  Expanded(
                    child: Text(
                        "If you’re in a public place, be careful to display the QR code.",
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
    const double _qrSize = 240.0;

    return BlocBuilder<SecurityExportAccountCubit, SecurityExportAccountState>(
        builder: (context, state) {
      return state.loadUserDataStatus is LoadUserDataStatusSuccess
          ? Expanded(
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Your BOTP Account",
                          style: Theme.of(context).textTheme.bodyText1),
                      const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                      Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(
                                        boxShadowOffsetX, boxShadowOffsetY),
                                    blurRadius: boxShadowBlurRadius,
                                    color: Theme.of(context)
                                        .shadowColor
                                        .withOpacity(boxShadowOpacity))
                              ]),
                          child: Stack(children: [
                            RepaintBoundary(
                                key: qrKey,
                                child: QrImage(
                                    backgroundColor: Colors.white,
                                    version: QrVersions.auto,
                                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                                    data: state.privateKey!,
                                    size: _qrSize,
                                    gapless: false,
                                    embeddedImage: const AssetImage(
                                        "assets/images/logo/botp_logo_embedded_qr.png"),
                                    embeddedImageStyle: QrEmbeddedImageStyle(
                                      size: const Size(60, 60),
                                    ))),
                            Container(
                                color: Colors.white.withOpacity(
                                    state.isHiddenQrImage ? 1.0 : 0.0),
                                width: _qrSize,
                                height: _qrSize),
                          ])),
                      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                      ButtonTextWidget(
                          text: state.isHiddenQrImage
                              ? "Show QR image"
                              : "Hide QR image",
                          onPressed: () {
                            context
                                .read<SecurityExportAccountCubit>()
                                .flipQrImage();
                          })
                    ],
                  )
                ]))
          : Container();
    });
  }

  Widget _actionButtons() {
    return BlocConsumer<SecurityExportAccountCubit, SecurityExportAccountState>(
        listener: (context, state) {
      final saveQrImageStatus = state.saveQrImageStatus;
      if (saveQrImageStatus is RequestStatusFailed) {
        showSnackBar(context, saveQrImageStatus.exception.toString());
      } else if (saveQrImageStatus is RequestStatusSuccess) {
        showSnackBar(
            context, "Saved your QR image successfully.", SnackBarType.success);
      }
    }, builder: (context, state) {
      return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kAppPaddingHorizontalSize,
              vertical: kAppPaddingVerticalSize),
          child: Row(children: [
            Expanded(
                flex: 1,
                child: ButtonNormalWidget(
                  text: 'Save image',
                  onPressed: state.saveQrImageStatus is RequestStatusSubmitting
                      ? null
                      : () async {
                          await context
                              .read<SecurityExportAccountCubit>()
                              .saveQrImage(qrKey);
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
    });
  }
}
