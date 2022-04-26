import 'dart:ffi';

import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/utils/helpers/account.dart';
import 'package:botp_auth/widgets/common.dart';
import "package:flutter/material.dart";

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
        Theme.of(context).textTheme.bodyText2?.copyWith(color: _primary);
    // - Padding
    const _padding = EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0);
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

// Category
class SettingsCategoryWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String description;
  final ColorType colorType;

  const SettingsCategoryWidget(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.description,
      required this.colorType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Category theme
    // - Text
    final _titleStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontWeight: FontWeight.bold);
    final _descriptionStyle = Theme.of(context).textTheme.bodyText2;
    // - Padding
    const _padding = EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0);

    return Container(
        // decoration: BoxDecoration(
        //     // color: Theme.of(context).colorScheme.surface,
        //     // border: Border.all(color: Theme.of(context).colorScheme.outline),
        //     borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        padding: _padding,
        child: Row(children: [
          DecoratedIconWidget(
              colorType: colorType,
              size: DecoratedIconSize.normal,
              iconData: iconData),
          const SizedBox(width: 24.0),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title, style: _titleStyle),
                const SizedBox(height: 8.0),
                Text(description, style: _descriptionStyle)
              ])),
          Icon(Icons.navigate_next_outlined,
              color: Theme.of(context).colorScheme.onSurfaceVariant)
        ]));
  }
}

// Shadow for category item
class ShadowSettingsCategoryWidget extends StatelessWidget {
  const ShadowSettingsCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
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

// Settings section
class SettingsSectionWidget extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const SettingsSectionWidget({Key? key, this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _titleStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.bold);
    return Container(
        padding: const EdgeInsets.symmetric(
            vertical: kAppPaddingBetweenItemNormalSize),
        child: title != null
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kAppPaddingHorizontalSize),
                    child: Text(title!, style: _titleStyle)),
                const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                ...children,
              ])
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [...children]));
  }
}

// Core setting option widgets
class SettingsOptionWidget extends StatelessWidget {
  final SettingsOptionType type;
  final String label;
  final String value;
  final bool multiLine;
  final Widget? customWidget;
  final OptionButtonOneSide buttonSide;
  final ColorType buttonSideColorType;
  final bool switchValue;
  final ValueChanged<bool>? onSwitched;
  final bool isChecked;
  final String navigateDescription;
  final VoidCallback? onNavigate;
  const SettingsOptionWidget(
      {Key? key,
      this.type = SettingsOptionType.labelAndValue,
      this.label = "",
      this.value = "",
      this.multiLine = false,
      this.customWidget,
      this.buttonSide = OptionButtonOneSide.left,
      this.buttonSideColorType = ColorType.primary,
      this.switchValue = false,
      this.onSwitched,
      this.isChecked = false,
      this.navigateDescription = "",
      this.onNavigate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Option Theme
    // - Style
    final _labelStyle = Theme.of(context).textTheme.bodyText1;
    final _valueStyle = Theme.of(context).textTheme.bodyText2;
    final _descriptionStyle = Theme.of(context).textTheme.bodyText2;
    // Child widget
    final Widget _optionWidget;
    switch (type) {
      case SettingsOptionType.labelAndCustomWidget:
        _optionWidget = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: _labelStyle),
              customWidget ?? Container()
            ]);
        break;
      case SettingsOptionType.labelNavigable:
        _optionWidget =
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: _labelStyle),
          Row(
            children: [
              Text(navigateDescription, style: _descriptionStyle),
              const SizedBox(width: 8.0),
              Icon(Icons.navigate_next_outlined,
                  color: Theme.of(context).colorScheme.onSurfaceVariant)
            ],
          )
        ]);
        break;
      case SettingsOptionType.labelSelectable:
        _optionWidget =
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: _labelStyle),
          Icon(Icons.check_circle,
              color: Theme.of(context).colorScheme.secondary)
        ]);
        break;
      case SettingsOptionType.labelSwitchable:
        _optionWidget =
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: _labelStyle),
          Switch.adaptive(value: switchValue, onChanged: onSwitched)
        ]);
        break;
      case SettingsOptionType.buttonTextOneSide:
        final _textColor = buttonSideColorType == ColorType.primary
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.error;
        _optionWidget = Row(
            mainAxisAlignment: buttonSide == OptionButtonOneSide.left
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Text(label, style: _labelStyle?.copyWith(color: _textColor))
            ]);
        break;
      case SettingsOptionType.labelAndValue:
      default:
        _optionWidget =
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(flex: 1, child: Text(label, style: _labelStyle)),
          Expanded(
              flex: 1,
              child: Text(
                value,
                style: _valueStyle,
                textAlign: TextAlign.right,
              ))
        ]);
        break;
    }
    return _wrapSettingsOptionWidget(_optionWidget);
  }

  Widget _wrapSettingsOptionWidget(Widget child, [VoidCallback? onTap]) =>
      InkWell(
          onTap: onTap ?? () {},
          child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kAppPaddingHorizontalSize,
                  vertical: kAppPaddingBetweenItemSmallSize),
              child: child));
}
