import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/utils/helpers/transaction.dart';
import 'package:flutter/material.dart';

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
      case TransactionStatus.requesting:
        _primary = Theme.of(context).colorScheme.onTertiaryContainer;
        _backgroundColor = Theme.of(context).colorScheme.tertiaryContainer;
        break;
      case TransactionStatus.pending:
        _primary = Theme.of(context).colorScheme.onPrimaryContainer;
        _backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        break;
      case TransactionStatus.success:
        _primary = Theme.of(context).colorScheme.onSecondaryContainer;
        _backgroundColor = Theme.of(context).colorScheme.secondaryContainer;
        break;
      case TransactionStatus.failed:
        _primary = Theme.of(context).colorScheme.onErrorContainer;
        _backgroundColor = Theme.of(context).colorScheme.errorContainer;
        break;
      default: // Requesting
        _primary = Theme.of(context).colorScheme.onTertiaryContainer;
        _backgroundColor = Theme.of(context).colorScheme.tertiaryContainer;
    }
    // - Text
    final _textStyle = size == TransactionStatusSize.small
        ? Theme.of(context).textTheme.caption?.copyWith(color: _primary)
        : Theme.of(context).textTheme.bodyText1?.copyWith(color: _primary);
    // - Padding
    const _padding = EdgeInsets.symmetric(vertical: 3.0, horizontal: 12.0);

    return Container(
      decoration: BoxDecoration(color: _backgroundColor),
      padding: _padding,
      child: Text(status.toCapitalizedString(), style: _textStyle),
    );
  }
}

class TransactionItemWidget extends StatelessWidget {
  final bool isNewest;
  final String agentName;
  final String agentAvatarUrl;
  final bool agentIsVerified;
  final String timestamp;
  final String notifyMessage;
  final TransactionStatus transactionStatus;
  const TransactionItemWidget({
    Key? key,
    required this.isNewest,
    required this.agentName,
    required this.agentAvatarUrl,
    this.agentIsVerified = true,
    required this.timestamp,
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
          boxShadow: [
            BoxShadow(
                offset: const Offset(0.0, 2.0),
                blurRadius: 30.0,
                color: Theme.of(context).shadowColor.withOpacity(0.05))
          ],
        ),
        height: 94,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0),
                child: SizedBox(
                  height: 62.0,
                  width: 62.0,
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
                      timestamp,
                      style: _smallTextStyle,
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      shortenNotifyMessage(notifyMessage),
                      style: _smallTextStyle, // TODO: truncate
                    ),
                  ],
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 0.0),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20.0),
                    child: _TransactionStatusWidget(
                      status: transactionStatus,
                    ))
              ],
            )
          ],
        ));
  }
}

class TransactionOTP extends StatefulWidget {
  final String? otp;
  final int? otpRemainingTime;

  const TransactionOTP({Key? key, this.otp, this.otpRemainingTime})
      : super(key: key);

  @override
  State<TransactionOTP> createState() => _TransactionOTPState();
}

class _TransactionOTPState extends State<TransactionOTP> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("OTP", style: Theme.of(context).textTheme.headline6),
      const Divider(),
      widget.otp != null
          ? Text(widget.otp!)
          : const CircularProgressIndicator(),
      const Text("Tap to copy OTP"),
      // TODO: second mean
      widget.otpRemainingTime != null
          ? Text(widget.otpRemainingTime!.toString() + "s left")
          : const CircularProgressIndicator(),
    ]);
  }
}

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: const [Text("Shopee (verified)"), Text("")]),
        Row(
          children: const [Text("Address"), Text("0x123...456")],
        ),
        Row(
          children: const [Text("Date"), Text("23:54 - 15/06/2022")],
        ),
        Row(
          children: const [
            Text("Status"),
            _TransactionStatusWidget(status: TransactionStatus.pending)
          ],
        )
      ],
    );
  }
}

class TransactionNotifyMessage extends StatelessWidget {
  const TransactionNotifyMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text("Notify message"),
        Text(
            "[khiem20tc] Facebook need to confirm your account password. Authentication was request at 23:54 - 15/06/2022.")
      ],
    );
  }
}
