import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/routing_param.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import "package:flutter/material.dart";

class SecurityTransferAccountScreen extends StatelessWidget {
  const SecurityTransferAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(
        appBarTitle: "Transfer Account", body: SecurityTransferAccountBody());
  }
}

class SecurityTransferAccountBody extends StatelessWidget {
  const SecurityTransferAccountBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Transfer account theme
    final _titleStyle = Theme.of(context)
        .textTheme
        .headline5
        ?.copyWith(color: Theme.of(context).colorScheme.primary);

    return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: kAppPaddingVerticalSize),
          Text("Transfer your account",
              style: _titleStyle, textAlign: TextAlign.center),
          const SizedBox(height: kAppPaddingBetweenItemSmallSize),
          SizedBox(
            child: const Text(
              "Easily switch your accounts between any devices that have BOTP Authenticator",
              textAlign: TextAlign.center,
            ),
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          const SizedBox(height: 96.0),
          Row(children: [
            Expanded(
                flex: 1,
                child: SettingsTransferWidget(
                    iconData: Icons.output_outlined,
                    transferColorType: ColorType.secondary,
                    title: "Export account",
                    description: "Display/save your QR code",
                    onTap: () {
                      Application.router.navigateTo(
                          context, "/botp/settings/security/transfer/export");
                    })),
            const SizedBox(
              width: kAppPaddingBetweenItemSmallSize,
            ),
            Expanded(
                flex: 1,
                child: SettingsTransferWidget(
                    iconData: Icons.qr_code_scanner,
                    transferColorType: ColorType.primary,
                    title: "Import account",
                    description: "Scan QR code/Enter private key",
                    onTap: () {
                      Application.router.navigateTo(context, "/auth/import",
                          routeSettings: const RouteSettings(
                              arguments:
                                  FromScreen.botpSettingsAccountTransfer));
                    }))
          ]),
        ]));
  }
}
