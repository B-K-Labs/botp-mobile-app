import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/modules/botp/transaction/bloc/transaction_detail_bloc.dart';
import 'package:botp_auth/modules/botp/transaction/bloc/transaction_detail_state.dart';
import 'package:botp_auth/widgets/bars.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionDetail transactionDetail;
  const TransactionDetailsScreen(this.transactionDetail, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBarWidget.generate(context, title: "Authenticate Transaction"),
        body: TransactionDetailsBody(transactionDetail));
  }
}

class TransactionDetailsBody extends StatefulWidget {
  final TransactionDetail transactionDetail;
  const TransactionDetailsBody(this.transactionDetail, {Key? key})
      : super(key: key);

  @override
  State<TransactionDetailsBody> createState() => _TransactionDetailsBodyState();
}

class _TransactionDetailsBodyState extends State<TransactionDetailsBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionDetailBloc>(
        create: (context) => TransactionDetailBloc(
            authenticatorRepository: context.read<AuthenticatorRepository>(),
            transactionDetail: widget.transactionDetail),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_transactionDetailSection(), _actionButtons()],
        ));
  }

  Widget _actionButtons() {
    return BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
        builder: (context, state) {
      final Widget _returnActionButtons;
      final TransactionStatus transactionStatus =
          state.otpSessionInfo.transactionStatus;
      switch (transactionStatus) {
        case TransactionStatus.requesting:
          _returnActionButtons = Row(children: [
            Expanded(
                child: ButtonNormalWidget(
                    text: "Reject",
                    onPressed: () {},
                    type: ButtonNormalType.errorOutlined)),
            const SizedBox(width: kAppPaddingBetweenItemSmallSize),
            Expanded(
                child: ButtonNormalWidget(text: "Confirm", onPressed: () {}))
          ]);
          break;
        case TransactionStatus.pending:
          _returnActionButtons = Row(children: [
            Expanded(
                child: ButtonNormalWidget(
                    text: "Cancel",
                    onPressed: () {},
                    type: ButtonNormalType.errorOutlined)),
            const SizedBox(width: kAppPaddingBetweenItemSmallSize),
            Expanded(
                child: ButtonNormalWidget(
                    text: "Go to home",
                    onPressed: () {
                      Application.router.pop(context);
                    }))
          ]);
          break;
        case TransactionStatus.success:
          _returnActionButtons = ButtonNormalWidget(
              text: "Go to home",
              onPressed: () {
                Application.router.pop(context);
              });
          break;
        case TransactionStatus.failed:
          _returnActionButtons = ButtonNormalWidget(
              text: "Go to home",
              onPressed: () {
                Application.router.pop(context);
              });
          break;
        default: // Requesting
          _returnActionButtons = Row(children: [
            Expanded(
                child: ButtonNormalWidget(
                    text: "Reject",
                    onPressed: () {},
                    type: ButtonNormalType.errorOutlined)),
            const SizedBox(width: kAppPaddingBetweenItemSmallSize),
            Expanded(
                child: ButtonNormalWidget(text: "Confirm", onPressed: () {}))
          ]);
      }
      return Container(
          padding: const EdgeInsets.all(kAppPaddingHorizontalAndBottomSize),
          child: _returnActionButtons);
    });
  }

  Widget _transactionDetailSection() {
    return BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
        builder: (context, state) {
      final otpSessionInfo = state.otpSessionInfo;
      return Expanded(
          child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: kAppPaddingTopSize),
        Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kAppPaddingHorizontalAndBottomSize),
            child: TransactionOTPWidget(
                otpValueInfo:
                    OTPValueInfo(value: "123456", remainingSecond: 2))),
        const SizedBox(height: 24.0),
        Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kAppPaddingHorizontalAndBottomSize),
            child: TransactionDetailWidget(
              agentName: otpSessionInfo.agentName,
              agentIsVerified: otpSessionInfo.agentIsVerified,
              agentAvatarUrl: otpSessionInfo.agentAvatarUrl,
              agentBcAddress: otpSessionInfo.agentBcAddress,
              timestamp: otpSessionInfo.timestamp,
              transactionStatus: otpSessionInfo.transactionStatus,
            )),
        const SizedBox(height: 24.0),
        Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kAppPaddingHorizontalAndBottomSize),
            child: TransactionNotifyMessageWidget(
                notifyMessage: otpSessionInfo.notifyMessage)),
        const SizedBox(height: kAppPaddingHorizontalAndBottomSize),
      ])));
    });
  }
}
