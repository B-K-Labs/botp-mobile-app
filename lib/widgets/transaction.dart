import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/utils/helpers/transaction.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';

class _TransactionStatusWidget extends StatelessWidget {
  final TransactionStatus status;
  final bool hasBorder;

  const _TransactionStatusWidget(
      {Key? key, required this.status, this.hasBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Transaction Item theme
    // - Colors
    final Color primary;
    final Color backgroundColor;
    switch (status) {
      case TransactionStatus.waiting:
        primary = Theme.of(context).colorScheme.onPrimaryContainer;
        backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        break;
      case TransactionStatus.succeeded:
        primary = Theme.of(context).colorScheme.onSecondaryContainer;
        backgroundColor = Theme.of(context).colorScheme.secondaryContainer;
        break;
      case TransactionStatus.failed:
        primary = Theme.of(context).colorScheme.onErrorContainer;
        backgroundColor = Theme.of(context).colorScheme.errorContainer;
        break;
      case TransactionStatus.requesting:
      default:
        primary = Theme.of(context).colorScheme.onTertiaryContainer;
        backgroundColor = Theme.of(context).colorScheme.tertiaryContainer;
        break;
    }
    // - Text
    final textStyle =
        Theme.of(context).textTheme.bodySmall?.copyWith(color: primary);
    // - Padding
    const padding = EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0);
    // - Decoration
    final decoration = hasBorder
        ? BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(BorderRadiusSize.small))
        : BoxDecoration(color: backgroundColor);

    return Container(
      decoration: decoration,
      padding: padding,
      child: Text(status.toCapitalizedString(), style: textStyle),
    );
  }
}

class ShadowTransactionItemWidget extends StatelessWidget {
  const ShadowTransactionItemWidget({Key? key}) : super(key: key);

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

class TransactionItemWidget extends StatelessWidget {
  final bool isNewest;
  final String agentName;
  final String agentAvatarUrl;
  final bool agentIsVerified;
  final int timestamp;
  final String notifyMessage;
  final TransactionStatus transactionStatus;
  final VoidCallback? onTap;
  const TransactionItemWidget(
      {Key? key,
      required this.isNewest,
      required this.agentName,
      required this.agentAvatarUrl,
      this.agentIsVerified = true,
      required this.timestamp,
      required this.notifyMessage,
      required this.transactionStatus,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Transaction Item theme
    // - Colors
    final border = isNewest
        ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2.0)
        : null;
    // - Border
    final borderRadius = BorderRadius.circular(BorderRadiusSize.normal);
    // - Text
    final TextStyle? textStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontWeight: FontWeight.bold);
    final TextStyle? smallTextStyle = Theme.of(context).textTheme.bodySmall;
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: borderRadius,
          border: border,
        ),
        height: 80,
        child: Material(
            borderRadius: borderRadius,
            child: InkWell(
                borderRadius: borderRadius,
                onTap: onTap,
                child: Stack(alignment: AlignmentDirectional.topEnd, children: [
                  Positioned.fill(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16.0),
                            child: AgentAvatar(avatarUrl: agentAvatarUrl)),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      agentIsVerified
                                          ? Row(children: [
                                              Text(
                                                agentName,
                                                style: textStyle,
                                              ),
                                              const SizedBox(width: 6.0),
                                              Icon(Icons.verified,
                                                  size: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary)
                                            ])
                                          : Text(
                                              agentName,
                                              style: textStyle,
                                            ),
                                      const SizedBox(height: 6.0),
                                      Text(
                                        DateFormat('yyyy-MM-dd – kk:mm:ss')
                                            .format(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    timestamp)),
                                        style: smallTextStyle,
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        shortenNotifyMessage(
                                            'Message: $notifyMessage'),
                                        style: smallTextStyle,
                                      ),
                                    ],
                                  )
                                ]))),
                      ])),
                  Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: _TransactionStatusWidget(
                        status: transactionStatus,
                      ))
                ]))));
  }
}

class TransactionItemSkeletonWidget extends StatelessWidget {
  const TransactionItemSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: Stack(alignment: AlignmentDirectional.topEnd, children: [
          Positioned.fill(
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: const SkeletonAvatar(
                    style: SkeletonAvatarStyle(width: 48.0, height: 48.0))),
            const Expanded(
                flex: 1,
                child: Center(
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SkeletonLine(
                              style: SkeletonLineStyle(
                                  height: 18.0,
                                  randomLength: true,
                                  minLength: 80,
                                  maxLength: 120)),
                          SizedBox(height: 6.0),
                          SkeletonLine(
                              style: SkeletonLineStyle(
                                  height: 14.0,
                                  randomLength: true,
                                  minLength: 50,
                                  maxLength: 80)),
                          SizedBox(height: 4.0),
                          SkeletonLine(
                              style: SkeletonLineStyle(
                                  height: 14.0,
                                  randomLength: true,
                                  minLength: 100,
                                  maxLength: 200)),
                        ],
                      )
                    ]))),
          ])),
          Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: const SkeletonLine(
                  style: SkeletonLineStyle(
                      alignment: AlignmentDirectional.topEnd,
                      height: 22.0,
                      randomLength: true,
                      minLength: 50,
                      maxLength: 80)))
        ]));
  }
}

class TransactionOTPWidget extends StatefulWidget {
  final OTPValueInfo otpValueInfo;
  final VoidCallback? onTap;

  const TransactionOTPWidget({Key? key, required this.otpValueInfo, this.onTap})
      : super(key: key);

  @override
  State<TransactionOTPWidget> createState() => _TransactionOTPWidgetState();
}

class _TransactionOTPWidgetState extends State<TransactionOTPWidget> {
  @override
  Widget build(BuildContext context) {
    // OTP theme
    // - Color
    final Color primary;
    final Color backgroundColor;
    switch (widget.otpValueInfo.status) {
      case OTPValueStatus.valid:
        primary = Theme.of(context).colorScheme.primary;
        backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        break;
      case OTPValueStatus.nearlyExpired:
        primary = Theme.of(context).colorScheme.error;
        backgroundColor = Theme.of(context).colorScheme.errorContainer;
        break;
      case OTPValueStatus.expired:
        primary = Theme.of(context).colorScheme.error;
        backgroundColor = Theme.of(context).colorScheme.errorContainer;
        break;
      case OTPValueStatus.notAvailable:
        primary = Theme.of(context).colorScheme.error;
        backgroundColor = Theme.of(context).colorScheme.errorContainer;
        break;
      case OTPValueStatus.initial:
      default:
        primary = Theme.of(context).colorScheme.primary;
        backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        break;
    }
    // - Border
    final border = Border.all(color: primary, width: 3.0);
    final borderRadius = BorderRadius.circular(BorderRadiusSize.normal);
    // - Text
    final titleStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(fontWeight: FontWeight.bold);
    final otpStyle =
        Theme.of(context).textTheme.headlineMedium?.copyWith(color: primary);
    final captionStyle = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);
    // - Padding
    const padding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0);

    // Otp
    final otpValueInfo = widget.otpValueInfo;
    final isValidOtp = [OTPValueStatus.valid, OTPValueStatus.nearlyExpired]
        .contains(otpValueInfo.status);
    final isNotAvailableOtp =
        otpValueInfo.status == OTPValueStatus.notAvailable;
    return Stack(alignment: AlignmentDirectional.center, children: [
      AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubic,
        decoration: BoxDecoration(
          border: Border.all(
              color: backgroundColor,
              width: isValidOtp && otpValueInfo.remainingSecond % 2 == 0 ||
                      isNotAvailableOtp
                  ? 7.5
                  : 3.0),
          borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
        ),
        height: 266,
      ),
      Material(
          borderRadius: borderRadius,
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            child: Container(
              decoration:
                  BoxDecoration(border: border, borderRadius: borderRadius),
              padding: padding,
              height: 266,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      Text("OTP", style: titleStyle),
                      const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                      const DividerWidget(),
                      const SizedBox(height: kAppPaddingBetweenItemLargeSize),
                      [OTPValueStatus.valid, OTPValueStatus.nearlyExpired]
                              .contains(otpValueInfo.status)
                          ? Text(otpValueInfo.value, style: otpStyle)
                          : [OTPValueStatus.initial, OTPValueStatus.expired]
                                  .contains(otpValueInfo.status)
                              ? SkeletonLine(
                                  style: SkeletonLineStyle(
                                  width: 150,
                                  alignment: AlignmentDirectional.center,
                                  randomLength: false,
                                  height: 40,
                                  borderRadius: BorderRadius.circular(
                                      BorderRadiusSize.normal),
                                ))
                              : Text("Not available", style: otpStyle),
                      const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                      [OTPValueStatus.valid, OTPValueStatus.nearlyExpired]
                              .contains(otpValueInfo.status)
                          ? Text("Tap to copy OTP", style: captionStyle)
                          : otpValueInfo.status == OTPValueStatus.notAvailable
                              ? Text("Cannot generate OTP in this device",
                                  style: captionStyle)
                              : SkeletonLine(
                                  style: SkeletonLineStyle(
                                  width: 100,
                                  alignment: AlignmentDirectional.center,
                                  randomLength: false,
                                  height: 14,
                                  borderRadius: BorderRadius.circular(
                                      BorderRadiusSize.small),
                                ))
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      // If no error
                      [OTPValueStatus.valid, OTPValueStatus.nearlyExpired]
                              .contains(otpValueInfo.status)
                          ? Row(children: [
                              Text(
                                  "${otpValueInfo.remainingSecond}s left",
                                  style:
                                      captionStyle?.copyWith(color: primary)),
                              const SizedBox(
                                  width: kAppPaddingBetweenItemSmallSize),
                              Center(
                                  child: Container(
                                      padding:
                                          const EdgeInsets.only(right: 6.0),
                                      child: SizedBox(
                                          width: 12,
                                          height: 12,
                                          child:
                                              // Flip the circular
                                              Transform(
                                                  alignment: Alignment.center,
                                                  transform: Matrix4.rotationY(
                                                      math.pi),
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: otpValueInfo
                                                            .remainingSecond /
                                                        otpValueInfo
                                                            .totalSeconds,
                                                    strokeWidth: 12,
                                                    backgroundColor:
                                                        backgroundColor,
                                                    color: primary,
                                                  )))))
                            ])
                          : Text(
                              otpValueInfo.status == OTPValueStatus.expired
                                  ? "Syncing data"
                                  : otpValueInfo.status ==
                                          OTPValueStatus.notAvailable
                                      ? "Failed to generate OTP"
                                      : "Requesting",
                              style: captionStyle?.copyWith(color: primary))
                    ]),
                  ]),
            ),
          ))
    ]);
  }
}

class TransactionDetailWidget extends StatelessWidget {
  final String agentName;
  final String agentAvatarUrl;
  final bool agentIsVerified;
  final String agentBcAddress;
  final VoidCallback opTapBcAddress;
  final int timestamp;
  final TransactionStatus transactionStatus;
  final VoidCallback onTapViewProvenance;

  const TransactionDetailWidget(
      {Key? key,
      required this.agentName,
      required this.agentAvatarUrl,
      required this.agentIsVerified,
      required this.agentBcAddress,
      required this.opTapBcAddress,
      required this.timestamp,
      required this.transactionStatus,
      required this.onTapViewProvenance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(fontWeight: FontWeight.bold);
    final labelStyle = Theme.of(context).textTheme.bodyMedium;
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.outline, width: 1.0),
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Transaction details", style: headlineStyle),
            const SizedBox(height: 18.0),
            _transactionDetailTextLineWidget(
                agentIsVerified
                    ? Row(children: [
                        Text(agentName,
                            style: textStyle?.copyWith(
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8.0),
                        Tooltip(
                            message: '$agentName is verified',
                            child: Icon(Icons.verified,
                                size: 18,
                                color: Theme.of(context).colorScheme.secondary))
                      ])
                    : Text(agentName,
                        style:
                            textStyle?.copyWith(fontWeight: FontWeight.bold)),
                AgentAvatar(avatarUrl: agentAvatarUrl)),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            _transactionDetailTextLineWidget(
                Text("Address", style: labelStyle),
                BcAddressWidget(
                    bcAddress: agentBcAddress, onTap: opTapBcAddress)),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            const DividerWidget(),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            _transactionDetailTextLineWidget(
                Text("Date", style: labelStyle),
                Text(
                    DateFormat('yyyy-MM-dd – kk:mm:ss')
                        .format(DateTime.fromMillisecondsSinceEpoch(timestamp)),
                    style: textStyle)),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            _transactionDetailTextLineWidget(
                Text("Status", style: labelStyle),
                _TransactionStatusWidget(
                    status: transactionStatus, hasBorder: true)),
            const SizedBox(height: kAppPaddingBetweenItemNormalSize),
            _transactionDetailTextLineWidget(
                Container(),
                ButtonTextWidget(
                    text: "View provenance",
                    iconData: Icons.arrow_forward,
                    onPressed: onTapViewProvenance))
          ],
        ));
  }
}

class TransactionDetailSkeletonWidget extends StatelessWidget {
  const TransactionDetailSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(fontWeight: FontWeight.bold);
    final labelStyle = Theme.of(context).textTheme.bodyMedium;
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.outline, width: 1.0),
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Transaction details", style: headlineStyle),
            const SizedBox(height: 18.0),
            _transactionDetailTextLineWidget(
              const SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 16.0,
                      minLength: 100,
                      maxLength: 150,
                      randomLength: true)),
              const SkeletonAvatar(
                  style: SkeletonAvatarStyle(width: 48, height: 48)),
            ),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            _transactionDetailTextLineWidget(
                Text("Address", style: labelStyle),
                const SkeletonLine(
                    style: SkeletonLineStyle(height: 24.0, width: 120))),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            const DividerWidget(),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            _transactionDetailTextLineWidget(
                Text("Date", style: labelStyle),
                const SkeletonLine(
                    style: SkeletonLineStyle(height: 16.0, width: 146))),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            _transactionDetailTextLineWidget(
                Text("Status", style: labelStyle),
                const SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 22.0,
                        minLength: 50,
                        maxLength: 100,
                        randomLength: true))),
            const SizedBox(height: kAppPaddingBetweenItemNormalSize),
            _transactionDetailTextLineWidget(
                Container(),
                const SkeletonLine(
                    style: SkeletonLineStyle(height: 24.0, width: 142))),
          ],
        ));
  }
}

class TransactionNotifyMessageWidget extends StatelessWidget {
  final String notifyMessage;
  const TransactionNotifyMessageWidget({Key? key, required this.notifyMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(fontWeight: FontWeight.bold);
    final textStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(color: Theme.of(context).colorScheme.onSurface);
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.outline, width: 1.0),
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notify message", style: headlineStyle),
            const SizedBox(height: 18.0),
            _transactionDetailTextLineWidget(
                Text(notifyMessage, style: textStyle), null)
          ],
        ));
  }
}

class TransactionNotifyMessageSkeletonWidget extends StatelessWidget {
  const TransactionNotifyMessageSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(fontWeight: FontWeight.bold);
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.outline, width: 1.0),
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notify message", style: headlineStyle),
            const SizedBox(height: 18.0),
            _transactionDetailTextLineWidget(
                const SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 16.0, minLength: 150, maxLength: 300)),
                null)
          ],
        ));
  }
}

Widget _transactionDetailTextLineWidget(Widget label, Widget? value) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: value != null ? [label, value] : [Expanded(child: label)]);
}

// Agent
class AgentAvatar extends StatelessWidget {
  final String avatarUrl;
  final bool isVerified;
  const AgentAvatar({Key? key, required this.avatarUrl, this.isVerified = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 48.0,
        width: 48.0,
        child: avatarUrl.isNotEmpty
            ? Image.network(avatarUrl, scale: 1, fit: BoxFit.contain)
            : Image.asset("assets/images/temp/botp_temp.png",
                scale: 1, fit: BoxFit.contain));
  }
}
