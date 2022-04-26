import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/utils/helpers/transaction.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'dart:math' as math;

class _TransactionStatusWidget extends StatelessWidget {
  final TransactionStatus status;
  final TransactionStatusSize size;

  const _TransactionStatusWidget(
      {Key? key, required this.status, this.size = TransactionStatusSize.small})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Transaction Item theme
    // - Colors
    final Color _primary;
    final Color _backgroundColor;
    switch (status) {
      case TransactionStatus.pending:
        _primary = Theme.of(context).colorScheme.onPrimaryContainer;
        _backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        break;
      case TransactionStatus.succeeded:
        _primary = Theme.of(context).colorScheme.onSecondaryContainer;
        _backgroundColor = Theme.of(context).colorScheme.secondaryContainer;
        break;
      case TransactionStatus.failed:
        _primary = Theme.of(context).colorScheme.onErrorContainer;
        _backgroundColor = Theme.of(context).colorScheme.errorContainer;
        break;
      case TransactionStatus.requesting:
      default:
        _primary = Theme.of(context).colorScheme.onTertiaryContainer;
        _backgroundColor = Theme.of(context).colorScheme.tertiaryContainer;
        break;
    }
    // - Text
    final _textStyle = size == TransactionStatusSize.small
        ? Theme.of(context).textTheme.caption?.copyWith(color: _primary)
        : Theme.of(context).textTheme.bodyText2?.copyWith(color: _primary);
    // - Padding
    const _padding = EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0);
    // - Decoration
    final _decoration = size == TransactionStatusSize.normal
        ? BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(BorderRadiusSize.small))
        : BoxDecoration(color: _backgroundColor);

    return Container(
      decoration: _decoration,
      padding: _padding,
      child: Text(status.toCapitalizedString(), style: _textStyle),
    );
  }
}

class ShadowTransactionItemWidget extends StatelessWidget {
  const ShadowTransactionItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 94,
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
  final String date;
  final String notifyMessage;
  final TransactionStatus transactionStatus;
  const TransactionItemWidget({
    Key? key,
    required this.isNewest,
    required this.agentName,
    required this.agentAvatarUrl,
    this.agentIsVerified = true,
    required this.date,
    required this.notifyMessage,
    required this.transactionStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Transaction Item theme
    // - Colors
    final _border = isNewest
        ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2.0)
        : null;
    final _smallTextColor = Theme.of(context).colorScheme.onSurfaceVariant;
    // - Border
    final _borderRadius = BorderRadius.circular(BorderRadiusSize.normal);
    // - Text
    final TextStyle? _textStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontWeight: FontWeight.bold);
    final TextStyle? _smallTextStyle =
        Theme.of(context).textTheme.caption?.copyWith(color: _smallTextColor);
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: _borderRadius,
          border: _border,
        ),
        height: 94,
        width: double.infinity,
        child: Stack(alignment: AlignmentDirectional.topEnd, children: [
          Positioned.fill(
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 27.0, vertical: 23.0),
                child: SizedBox(
                  height: 48.0,
                  width: 48.0,
                  child: Image.network(agentAvatarUrl,
                      scale: 1, fit: BoxFit.fitWidth),
                )),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 16.0),
                    Text(
                      agentName,
                      style: _textStyle,
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      date,
                      style: _smallTextStyle,
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      shortenNotifyMessage(notifyMessage),
                      style: _smallTextStyle,
                    ),
                  ],
                )),
          ])),
          Container(
              padding: const EdgeInsets.only(top: 16.0),
              child: _TransactionStatusWidget(
                status: transactionStatus,
              ))
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
    final Color _primary;
    final Color _backgroundColor;
    switch (widget.otpValueInfo.status) {
      case OTPValueStatus.valid:
        _primary = Theme.of(context).colorScheme.primary;
        _backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        break;
      case OTPValueStatus.nearlyExpired:
        _primary = Theme.of(context).colorScheme.error;
        _backgroundColor = Theme.of(context).colorScheme.errorContainer;
        break;
      case OTPValueStatus.expired:
        _primary = Theme.of(context).colorScheme.error;
        _backgroundColor = Theme.of(context).colorScheme.errorContainer;
        break;
      case OTPValueStatus.notAvailable:
        _primary = Theme.of(context).colorScheme.error;
        _backgroundColor = Theme.of(context).colorScheme.errorContainer;
        break;
      case OTPValueStatus.initial:
      default:
        _primary = Theme.of(context).colorScheme.primary;
        _backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        break;
    }
    // - Border
    final _border = Border.all(color: _primary, width: 3.0);
    // - Text
    final _otpStyle =
        Theme.of(context).textTheme.headline4?.copyWith(color: _primary);
    final _captionStyle = Theme.of(context)
        .textTheme
        .caption
        ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);
    // - Padding
    const _padding = EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0);

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
              color: _backgroundColor,
              width: isValidOtp && otpValueInfo.remainingSecond % 2 == 0 ||
                      isNotAvailableOtp
                  ? 7.5
                  : 3.0),
          borderRadius: BorderRadius.circular(BorderRadiusSize.normal),
        ),
        height: 266,
      ),
      InkWell(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
              border: _border,
              borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
          padding: _padding,
          height: 266,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  Text("OTP", style: Theme.of(context).textTheme.headline6),
                  const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                  const DividerWidget(),
                  const SizedBox(height: kAppPaddingBetweenItemLargeSize),
                  [OTPValueStatus.valid, OTPValueStatus.nearlyExpired]
                          .contains(otpValueInfo.status)
                      ? Text(otpValueInfo.value, style: _otpStyle)
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
                          : Text("Not available", style: _otpStyle),
                  const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                  [OTPValueStatus.valid, OTPValueStatus.nearlyExpired]
                          .contains(otpValueInfo.status)
                      ? Text("Tap to copy OTP", style: _captionStyle)
                      : otpValueInfo.status == OTPValueStatus.notAvailable
                          ? Text("Cannot generate OTP in this device",
                              style: _captionStyle)
                          : SkeletonLine(
                              style: SkeletonLineStyle(
                              width: 100,
                              alignment: AlignmentDirectional.center,
                              randomLength: false,
                              height: 14,
                              borderRadius:
                                  BorderRadius.circular(BorderRadiusSize.small),
                            ))
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  // If no error
                  [OTPValueStatus.valid, OTPValueStatus.nearlyExpired]
                          .contains(otpValueInfo.status)
                      ? Row(children: [
                          Text(
                              otpValueInfo.remainingSecond.toString() +
                                  "s left",
                              style: _captionStyle?.copyWith(color: _primary)),
                          const SizedBox(
                              width: kAppPaddingBetweenItemSmallSize),
                          Center(
                              child: Container(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: SizedBox(
                                      width: 12,
                                      height: 12,
                                      child:
                                          // Flip the circular
                                          Transform(
                                              alignment: Alignment.center,
                                              transform:
                                                  Matrix4.rotationY(math.pi),
                                              child: CircularProgressIndicator(
                                                value: otpValueInfo
                                                        .remainingSecond /
                                                    otpValueInfo.totalSeconds,
                                                strokeWidth: 12,
                                                backgroundColor:
                                                    _backgroundColor,
                                                color: _primary,
                                              )))))
                        ])
                      : Text(
                          otpValueInfo.status == OTPValueStatus.expired
                              ? "Syncing data"
                              : otpValueInfo.status ==
                                      OTPValueStatus.notAvailable
                                  ? "Failed to generate OTP"
                                  : "Requesting",
                          style: _captionStyle?.copyWith(color: _primary))
                ]),
              ]),
        ),
      )
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

  const TransactionDetailWidget(
      {Key? key,
      required this.agentName,
      required this.agentAvatarUrl,
      required this.agentIsVerified,
      required this.agentBcAddress,
      required this.opTapBcAddress,
      required this.timestamp,
      required this.transactionStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _headlineStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontWeight: FontWeight.bold);
    final _labelStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);
    final _textStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(color: Theme.of(context).colorScheme.onSurface);
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
            _transactionDetailTextLineWidget(
              Text(agentIsVerified ? '$agentName (verified)' : agentName,
                  style: _labelStyle),
              SizedBox(
                height: 48.0,
                width: 48.0,
                child: Image.network(agentAvatarUrl,
                    scale: 1, fit: BoxFit.fitWidth),
              ),
            ),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            _transactionDetailTextLineWidget(
                Text("Address", style: _labelStyle),
                BcAddressWidget(
                    bcAddress: agentBcAddress, onTap: opTapBcAddress)),
            const SizedBox(height: kAppPaddingBetweenItemNormalSize),
            const DividerWidget(),
            const SizedBox(height: kAppPaddingBetweenItemNormalSize),
            _transactionDetailTextLineWidget(
                Text("Date", style: _labelStyle),
                Text(DateTime.fromMillisecondsSinceEpoch(timestamp).toString(),
                    style: _textStyle)),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            _transactionDetailTextLineWidget(
                Text("Status", style: _labelStyle),
                _TransactionStatusWidget(
                    status: transactionStatus,
                    size: TransactionStatusSize.normal)),
          ],
        ));
  }
}

class TransactionDetailSkeletonWidget extends StatelessWidget {
  const TransactionDetailSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _headlineStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontWeight: FontWeight.bold);
    final _labelStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);
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
            _transactionDetailTextLineWidget(
              const SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 19.0,
                      minLength: 100,
                      maxLength: 150,
                      randomLength: true)),
              const SkeletonAvatar(
                  style: SkeletonAvatarStyle(width: 48, height: 48)),
            ),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            _transactionDetailTextLineWidget(
                Text("Address", style: _labelStyle),
                const SkeletonLine(
                    style: SkeletonLineStyle(height: 24.0, width: 120))),
            const SizedBox(height: kAppPaddingBetweenItemNormalSize),
            const DividerWidget(),
            const SizedBox(height: kAppPaddingBetweenItemNormalSize),
            _transactionDetailTextLineWidget(
                Text("Date", style: _labelStyle),
                const SkeletonLine(
                    style: SkeletonLineStyle(height: 19.0, width: 162))),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            _transactionDetailTextLineWidget(
                Text("Status", style: _labelStyle),
                const SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 24.0,
                        minLength: 50,
                        maxLength: 100,
                        randomLength: true))),
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
    final _headlineStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontWeight: FontWeight.bold);
    final _textStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(color: Theme.of(context).colorScheme.onSurface);
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.outline, width: 1.0),
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notify message", style: _headlineStyle),
            const SizedBox(height: 18.0),
            _transactionDetailTextLineWidget(
                Text(notifyMessage, style: _textStyle), null)
          ],
        ));
  }
}

class TransactionNotifyMessageSkeletonWidget extends StatelessWidget {
  const TransactionNotifyMessageSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _headlineStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontWeight: FontWeight.bold);
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.outline, width: 1.0),
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notify message", style: _headlineStyle),
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
