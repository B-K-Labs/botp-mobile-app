import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/utils/helpers/account.dart';
import "package:flutter/material.dart";
import 'package:skeletons/skeletons.dart';

// Home Info

class SettingsHomeInfo extends StatelessWidget {
  final String? avatarUrl;
  final String fullName;
  final String bcAddress;
  final VoidCallback? onTapBcAddress;
  const SettingsHomeInfo(
      {Key? key,
      this.avatarUrl,
      required this.fullName,
      required this.bcAddress,
      this.onTapBcAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Avatar
      Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(boxShadowOffsetX, boxShadowOffsetY),
                    blurRadius: boxShadowBlurRadius,
                    color: Theme.of(context)
                        .shadowColor
                        .withOpacity(boxShadowOpacity))
              ]),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: avatarUrl != null
                ? Image.network(avatarUrl!)
                : Image.asset("assets/images/temp/botp_temp.png",
                    scale: 1, fit: BoxFit.fitWidth),
          )),
      const SizedBox(height: 24.0),
      // FullName
      Text(fullName,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: Theme.of(context).colorScheme.primary)),
      const SizedBox(height: 12.0),
      // Blockchain address
      Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
            child: BcAddressWidget(
          bcAddress: bcAddress,
          onTap: onTapBcAddress,
        ))
      ])
    ]);
  }
}

// Bc address info
class BcAddressWidget extends StatelessWidget {
  final String bcAddress;
  final VoidCallback? onTap;

  const BcAddressWidget({Key? key, required this.bcAddress, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Transaction Item theme
    // - Colors
    final Color _primary = Theme.of(context).colorScheme.onSurfaceVariant;
    final Color _backgroundColor = Theme.of(context).colorScheme.surfaceVariant;
    // - Text
    final _textStyle =
        Theme.of(context).textTheme.bodyText1?.copyWith(color: _primary);
    // - Padding
    const _padding = EdgeInsets.symmetric(vertical: 3.0, horizontal: 12.0);
    // - Decoration
    final _decoration = BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(BorderRadiusSize.small));

    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: _decoration,
          padding: _padding,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(shortenBcAddress(bcAddress), style: _textStyle),
            const SizedBox(width: 8.0),
            Icon(Icons.copy, size: 16.0, color: _primary)
          ]),
        ));
  }
}

// Core setting option widgets
class SettingsOptionWidget extends StatelessWidget {
  final SettingsOptionType optionType;
  const SettingsOptionWidget(
      {Key? key, this.optionType = SettingsOptionType.textNormalValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
