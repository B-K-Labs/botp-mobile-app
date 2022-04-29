import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/utils/helpers/account.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/transaction.dart';
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
        Theme.of(context).textTheme.caption?.copyWith(color: _primary);
    // - Border
    final _borderRadius = BorderRadius.circular(BorderRadiusSize.small);
    // - Padding
    const _padding = EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0);
    // - Decoration
    final _decoration =
        BoxDecoration(color: _backgroundColor, borderRadius: _borderRadius);

    return Tooltip(
        message: bcAddress,
        child: Container(
            decoration: _decoration,
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: _borderRadius,
                  onTap: onTap,
                  child: Container(
                      padding: _padding,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(shortenBcAddress(bcAddress),
                                style: _textStyle),
                            const SizedBox(width: 8.0),
                            Icon(Icons.copy, size: 16.0, color: _primary)
                          ])),
                ))));
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
                        .withOpacity(boxShadowOpacity / 2))
              ]),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: avatarUrl != null
                ? Image.network(avatarUrl!)
                : Image.asset("assets/images/logo/botp_logo_embedded_qr.png",
                    scale: 1, fit: BoxFit.contain),
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
    const _padding = EdgeInsets.symmetric(
        vertical: kAppPaddingBetweenItemSmallSize,
        horizontal: kAppPaddingBetweenItemNormalSize);

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
          const SizedBox(width: kAppPaddingBetweenItemNormalSize),
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

// // Shadow for category item
// class ShadowSettingsCategoryWidget extends StatelessWidget {
//   const ShadowSettingsCategoryWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 70,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
//         boxShadow: [
//           BoxShadow(
//               offset: const Offset(boxShadowOffsetX, boxShadowOffsetY),
//               blurRadius: boxShadowBlurRadius,
//               color:
//                   Theme.of(context).shadowColor.withOpacity(boxShadowOpacity))
//         ],
//       ),
//     );
//   }
// }

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
                        horizontal: kAppPaddingHorizontalSize,
                        vertical: kAppPaddingBetweenItemSmallSize),
                    child: Text(title!, style: _titleStyle)),
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
  final VoidCallback? onTap;
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
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Option Theme
    // - Style
    final _labelStyle = Theme.of(context).textTheme.bodyText2;
    final _valueStyle = Theme.of(context).textTheme.caption;
    final _descriptionStyle = Theme.of(context).textTheme.caption;
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
        return _wrapSettingsOptionWidget(
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(label, style: _labelStyle),
              Switch.adaptive(value: switchValue, onChanged: onSwitched)
            ]),
            onTap,
            hasPadding: false);
      case SettingsOptionType.buttonTextOneSide:
        final _buttonType = buttonSideColorType == ColorType.primary
            ? ButtonNormalType.primary
            : ButtonNormalType.error;
        return _wrapSettingsOptionWidget(
            Row(
                mainAxisAlignment: buttonSide == OptionButtonOneSide.left
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  ButtonNormalWidget(
                      type: _buttonType,
                      text: label,
                      onPressed: onTap,
                      mode: ButtonNormalMode.normal,
                      size: ButtonNormalSize.small)
                ]),
            onTap,
            hasPadding: false);
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
    return _wrapSettingsOptionWidget(_optionWidget, onTap);
  }

  Widget _wrapSettingsOptionWidget(Widget child, VoidCallback? onTap,
          {EdgeInsets? padding, bool hasPadding = true}) =>
      Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: onTap ?? () {},
              child: Container(
                  padding: padding ??
                      (hasPadding
                          ? const EdgeInsets.symmetric(
                              horizontal: kAppPaddingHorizontalSize,
                              vertical: kAppPaddingBetweenItemSmallSize)
                          : const EdgeInsets.symmetric(
                              horizontal: kAppPaddingHorizontalSize)),
                  child: child)));
}

class SettingsTransferWidget extends StatelessWidget {
  final IconData iconData;
  final ColorType transferColorType;
  final String title;
  final String description;
  final VoidCallback? onTap;
  const SettingsTransferWidget(
      {Key? key,
      required this.iconData,
      required this.transferColorType,
      required this.title,
      required this.description,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Text style
    final _titleStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(fontWeight: FontWeight.bold);
    final _descriptionStyle = Theme.of(context).textTheme.caption;

    return Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
            onTap: onTap,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(BorderRadiusSize.normal),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 1.0)),
                padding: const EdgeInsets.symmetric(
                    horizontal: kAppPaddingBetweenItemSmallSize,
                    vertical: kAppPaddingBetweenItemSmallSize),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DecoratedIconWidget(
                          colorType: transferColorType,
                          size: DecoratedIconSize.normal,
                          iconData: iconData),
                      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                      Text(title, style: _titleStyle),
                      const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                      Text(description, style: _descriptionStyle),
                    ]))));
  }
}

class AgentInfoWidget extends StatelessWidget {
  final AgentInfo agentInfo;
  final VoidCallback opTapBcAddress;

  const AgentInfoWidget(
      {Key? key, required this.agentInfo, required this.opTapBcAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _headlineStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontWeight: FontWeight.bold);
    final _labelStyle = Theme.of(context).textTheme.bodyText2;
    final _textStyle = Theme.of(context).textTheme.bodyText2;
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.outline, width: 1.0),
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Transaction details", style: _headlineStyle),
            const SizedBox(height: 18.0),
            _agentInfoTextLineWidget(
              agentInfo.isVerified
                  ? Row(children: [
                      Text(agentInfo.name,
                          style: _labelStyle?.copyWith(
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8.0),
                      Tooltip(
                          child: Icon(Icons.verified,
                              size: 18,
                              color: Theme.of(context).colorScheme.secondary),
                          message: '${agentInfo.name} is verified')
                    ])
                  : Text(agentInfo.name,
                      style:
                          _labelStyle?.copyWith(fontWeight: FontWeight.bold)),
              AgentAvatar(avatarUrl: agentInfo.avatarUrl),
            ),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            _agentInfoTextLineWidget(
                Text("Address", style: _labelStyle),
                BcAddressWidget(
                    bcAddress: agentInfo.bcAddress, onTap: opTapBcAddress)),
          ],
        ));
  }
}

Widget _agentInfoTextLineWidget(Widget label, Widget? value) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: value != null ? [label, value] : [Expanded(child: label)]);
}
