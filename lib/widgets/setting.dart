import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/utils/helpers/account.dart';
import "package:flutter/material.dart";

class BcAddressWidget extends StatelessWidget {
  final String bcAddress;
  final VoidCallback? opTap;

  const BcAddressWidget({Key? key, required this.bcAddress, this.opTap})
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
        onTap: opTap,
        child: Container(
          decoration: _decoration,
          padding: _padding,
          child: Row(children: [
            Text(shortenBcAddress(bcAddress), style: _textStyle),
            const SizedBox(width: 8.0),
            Icon(Icons.copy, size: 16.0, color: _primary)
          ]),
        ));
  }
}

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
