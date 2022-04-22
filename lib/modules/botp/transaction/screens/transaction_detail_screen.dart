import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/modules/botp/transaction/bloc/transaction_detail_bloc.dart';
import 'package:botp_auth/modules/botp/transaction/bloc/transaction_detail_event.dart';
import 'package:botp_auth/modules/botp/transaction/bloc/transaction_detail_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
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
            otpSessionSecretInfo: widget.transactionDetail.otpSessionSecretInfo)
          ..add(TransactionDetailEventGetTransactionDetailAndSetupTimer()),
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
      final TransactionStatus? transactionStatus =
          state.otpSessionInfo?.transactionStatus;
      switch (transactionStatus) {
        case TransactionStatus.requesting:
          _returnActionButtons = Row(children: [
            Expanded(
                child: ButtonNormalWidget(
                    text: "Reject",
                    onPressed: () {
                      context
                          .read<TransactionDetailBloc>()
                          .add(TransactionDetailEventRejectTransaction());
                    },
                    type: ButtonNormalType.errorOutlined)),
            const SizedBox(width: kAppPaddingBetweenItemSmallSize),
            Expanded(
                child: ButtonNormalWidget(
              text: "Confirm",
              onPressed: () {
                context
                    .read<TransactionDetailBloc>()
                    .add(TransactionDetailEventConfirmTransaction());
              },
            ))
          ]);
          break;
        case TransactionStatus.pending:
          _returnActionButtons = Row(children: [
            Expanded(
                child: ButtonNormalWidget(
                    text: "Cancel",
                    onPressed: () {
                      context
                          .read<TransactionDetailBloc>()
                          .add(TransactionDetailEventCancelTransaction());
                    },
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
        default: // Null
          _returnActionButtons = Container(); // Null widget
      }
      return Container(
          padding: const EdgeInsets.all(kAppPaddingHorizontalAndBottomSize),
          child: _returnActionButtons);
    });
  }

  Widget _transactionDetailSection() {
    return BlocConsumer<TransactionDetailBloc, TransactionDetailState>(
        listener: (context, state) {
      final getTransactionDetailStatus = state.getTransactionDetailStatus;
      final userRequestStatus = state.userRequestStatus;
      if (userRequestStatus is RequestStatusFailed) {
        showSnackBar(context, userRequestStatus.exception.toString());
      }
    }, builder: (context, state) {
      final otpSessionInfo = state.otpSessionInfo;
      return Expanded(
          child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
        // Show OTP only in the pending state
        const SizedBox(height: kAppPaddingTopSize),
        _transactionOTP(),
        _transactionDetail(),
        _transactionNotifyMessage(),
        const SizedBox(height: kAppPaddingHorizontalAndBottomSize),
      ])));
    });
  }

  Widget _transactionOTP() {
    return BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
        builder: (context, state) {
      final otpValueInfo = state.otpValueInfo;
      return otpValueInfo.status != OTPValueStatus.notAvailable
          ? Column(children: [
              const SizedBox(height: 24.0),
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kAppPaddingHorizontalAndBottomSize),
                  child: TransactionOTPWidget(
                      otpValueInfo: OTPValueInfo(
                          value: otpValueInfo.value,
                          remainingSecond: otpValueInfo.remainingSecond)))
            ])
          : Container();
    });
  }

  Widget _transactionDetail() {
    return BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
        builder: (context, state) {
      final otpSessionInfo = state.otpSessionInfo;
      return otpSessionInfo != null
          ? Column(children: [
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
                  ))
            ])
          : Container();
    });
  }

  Widget _transactionNotifyMessage() {
    return BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
        builder: (context, state) {
      final otpSessionInfo = state.otpSessionInfo;
      return otpSessionInfo != null
          ? Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kAppPaddingHorizontalAndBottomSize),
              child: TransactionNotifyMessageWidget(
                  notifyMessage: otpSessionInfo.notifyMessage))
          : Container();
    });
  }
}
