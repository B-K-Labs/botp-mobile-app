import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/utils/helpers/account.dart';
import 'package:botp_auth/widgets/common.dart';
import "package:flutter/material.dart";

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

// Settings category
class SettingsCategoryWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String description;
  final DecorationIconColorType categoryType;

  const SettingsCategoryWidget(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.description,
      required this.categoryType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Category theme
    // - Color
    final Color _primary;
    final Color _backgroundColor;
    switch (categoryType) {
      case DecorationIconColorType.primary:
        _primary = Theme.of(context).colorScheme.onPrimaryContainer;
        _backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        break;
      case DecorationIconColorType.error:
        _primary = Theme.of(context).colorScheme.onErrorContainer;
        _backgroundColor = Theme.of(context).colorScheme.errorContainer;
        break;
      case DecorationIconColorType.secondary:
        _primary = Theme.of(context).colorScheme.onSecondaryContainer;
        _backgroundColor = Theme.of(context).colorScheme.secondaryContainer;
        break;
      case DecorationIconColorType.tertiary:
        _primary = Theme.of(context).colorScheme.onTertiaryContainer;
        _backgroundColor = Theme.of(context).colorScheme.tertiaryContainer;
        break;
      default: // Account
        _primary = Theme.of(context).colorScheme.onPrimaryContainer;
        _backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        break;
    }
    // - Text
    final _titleStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(fontWeight: FontWeight.bold);
    final _descriptionStyle = Theme.of(context).textTheme.bodyText2;
    // - Padding
    const _padding = EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0);

    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        padding: _padding,
        child: Row(children: [
          DecoratedIconWidget(
              colorContainer: _backgroundColor,
              onColorContainer: _primary,
              iconData: iconData),
          const SizedBox(width: 24.0),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title, style: _titleStyle),
                const SizedBox(height: 4),
                Text(description, style: _descriptionStyle)
              ])),
          Icon(Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.onSurfaceVariant, size: 16.0)
        ]));
  }
}

// Shadow for category item
class ShadowSettingsCategoryItem extends StatelessWidget {
  const ShadowSettingsCategoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
        boxShadow: [
          BoxShadow(
              offset: const Offset(boxShadowOffsetX, boxShadowOffsetY),
              blurRadius: boxShadowBlurRadius,
              color:
                  Theme.of(context).shadowColor.withOpacity(boxShadowOpacity))
        ],
      ),
    );
  }
}

// Blockchain address info
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

//

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
