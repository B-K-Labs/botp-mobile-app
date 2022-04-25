import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/modules/botp/transaction/bloc/transaction_detail_bloc.dart';
import 'package:botp_auth/modules/botp/transaction/bloc/transaction_detail_event.dart';
import 'package:botp_auth/modules/botp/transaction/bloc/transaction_detail_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionDetail transactionDetail;
  const TransactionDetailScreen(this.transactionDetail, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBarWidget.generate(context, title: "Authenticate Transaction"),
        body: TransactionDetailBody(transactionDetail));
  }
}

class TransactionDetailBody extends StatefulWidget {
  final TransactionDetail transactionDetail;
  const TransactionDetailBody(this.transactionDetail, {Key? key})
      : super(key: key);

  @override
  State<TransactionDetailBody> createState() => _TransactionDetailBodyState();
}

class _TransactionDetailBodyState extends State<TransactionDetailBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionDetailBloc>(
        create: (context) => TransactionDetailBloc(
            authenticatorRepository: context.read<AuthenticatorRepository>(),
            otpSessionSecretInfo: widget.transactionDetail.otpSessionSecretInfo)
          ..add(TransactionDetailEventGetTransactionDetailAndRunSetupTimers()),
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
                    onPressed: state.userRequestStatus
                            is RequestStatusSubmitting
                        ? null
                        : () {
                            context
                                .read<TransactionDetailBloc>()
                                .add(TransactionDetailEventRejectTransaction());
                          },
                    type: ButtonNormalType.errorOutlined)),
            const SizedBox(width: kAppPaddingBetweenItemSmallSize),
            Expanded(
                child: ButtonNormalWidget(
              text: "Confirm",
              onPressed: state.userRequestStatus is RequestStatusSubmitting
                  ? null
                  : () {
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
                    onPressed: state.userRequestStatus
                            is RequestStatusSubmitting
                        ? null
                        : () {
                            context
                                .read<TransactionDetailBloc>()
                                .add(TransactionDetailEventCancelTransaction());
                          },
                    type: ButtonNormalType.errorOutlined)),
            const SizedBox(width: kAppPaddingBetweenItemSmallSize),
            Expanded(
                child: ButtonNormalWidget(
                    text: "Go to home",
                    onPressed:
                        state.userRequestStatus is RequestStatusSubmitting
                            ? null
                            : () {
                                Application.router.pop(context);
                              }))
          ]);
          break;
        case TransactionStatus.succeeded:
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
          padding: const EdgeInsets.symmetric(
              horizontal: kAppPaddingHorizontalSize,
              vertical: kAppPaddingBottomSize),
          child: _returnActionButtons);
    });
  }

  Widget _transactionDetailSection() {
    return BlocConsumer<TransactionDetailBloc, TransactionDetailState>(
        listener: (context, state) {
      final userRequestStatus = state.userRequestStatus;
      final generateOtpStatus = state.generateOtpStatus;
      final getTransactionDetailStatus = state.getTransactionDetailStatus;
      final copyBcAddressStatus = state.copyBcAddressStatus;
      final copyOtpStatus = state.copyOtpStatus;
      // Failed result
      if (userRequestStatus is RequestStatusFailed) {
        showSnackBar(context, userRequestStatus.exception.toString());
      }
      if (generateOtpStatus is RequestStatusFailed) {
        showSnackBar(context, generateOtpStatus.exception.toString());
      }
      if (getTransactionDetailStatus is RequestStatusFailed) {
        showSnackBar(context, getTransactionDetailStatus.exception.toString());
      }
      // Copy actions
      if (copyBcAddressStatus is SetClipboardStatusSuccess) {
        showSnackBar(
            context, "Blockchain address copied.", SnackBarType.success);
      } else if (copyBcAddressStatus is SetClipboardStatusFailed) {
        showSnackBar(context, "Failed to copy blockchain address.");
      }
      if (copyOtpStatus is SetClipboardStatusSuccess) {
        showSnackBar(context, "OTP copied.", SnackBarType.success);
      } else if (copyOtpStatus is SetClipboardStatusFailed) {
        showSnackBar(context, "Failed to copy OTP.");
      }
    }, builder: (context, state) {
      final otpSessionInfo = state.otpSessionInfo;
      return otpSessionInfo != null
          ? Expanded(
              child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(height: kAppPaddingBetweenItemNormalSize),
              // Show OTP only in the pending state
              otpSessionInfo.transactionStatus == TransactionStatus.pending
                  ? _transactionOTP()
                  : Container(),
              _transactionDetail(),
              _transactionNotifyMessage(),
              const SizedBox(height: kAppPaddingHorizontalSize),
            ])))
          : Container();
    });
  }

  Widget _transactionOTP() {
    return BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
        builder: (context, state) {
      final otpValueInfo = state.otpValueInfo;
      _onTapOtp() {
        context
            .read<TransactionDetailBloc>()
            .add(TransactionDetailEventCopyOTP());
      }

      return Column(children: [
        Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kAppPaddingHorizontalSize),
            child: TransactionOTPWidget(
                otpValueInfo: otpValueInfo, onTap: _onTapOtp)),
        const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      ]);
    });
  }

  Widget _transactionDetail() {
    return BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
        builder: (context, state) {
      final otpSessionInfo = state.otpSessionInfo;
      _onTapBcAddress() {
        context
            .read<TransactionDetailBloc>()
            .add(TransactionDetailEventCopyBcAddress());
      }

      return otpSessionInfo != null
          ? Column(children: [
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kAppPaddingHorizontalSize),
                  child: TransactionDetailWidget(
                    agentName: otpSessionInfo.agentName,
                    agentIsVerified: otpSessionInfo.agentIsVerified,
                    agentAvatarUrl: otpSessionInfo.agentAvatarUrl,
                    agentBcAddress: otpSessionInfo.agentBcAddress,
                    timestamp: otpSessionInfo.timestamp,
                    transactionStatus: otpSessionInfo.transactionStatus,
                    opTapBcAddress: _onTapBcAddress,
                  )),
              const SizedBox(height: kAppPaddingBetweenItemNormalSize),
            ])
          : Container();
    });
  }

  Widget _transactionNotifyMessage() {
    return BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
        builder: (context, state) {
      final otpSessionInfo = state.otpSessionInfo;
      return otpSessionInfo != null
          ? Column(children: [
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kAppPaddingHorizontalSize),
                  child: TransactionNotifyMessageWidget(
                      notifyMessage: otpSessionInfo.notifyMessage)),
              const SizedBox(height: kAppPaddingBetweenItemNormalSize),
            ])
          : Container();
    });
  }
}
