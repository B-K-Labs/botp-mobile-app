import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_bloc.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_event.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticatorBody extends StatefulWidget {
  const AuthenticatorBody({Key? key}) : super(key: key);

  @override
  State<AuthenticatorBody> createState() => _AuthenticatorBodyState();
}

class _AuthenticatorBodyState extends State<AuthenticatorBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticatorBloc>(
        create: (context) => AuthenticatorBloc(
            authenticatorRepository: context.read<AuthenticatorRepository>())
          // https://stackoverflow.com/questions/62648103/triggering-initial-event-in-bloc
          ..add(AuthenticatorEventGetTransactionsList()),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _reminder(),
              _filter(),
              _transactionItemsList(),
            ]));
  }

  // 1. Reminder
  Widget _reminder() {
    return BlocBuilder<AuthenticatorBloc, AuthenticatorState>(
        builder: (context, state) {
      return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kAppPaddingHorizontalAndBottomSize),
          child: ButtonNormalWidget(
              text: "Refresh",
              onPressed: () {
                context
                    .read<AuthenticatorBloc>()
                    .add(AuthenticatorEventGetTransactionsList());
              }));
    });
  }

  // 2. Transaction filter
  Widget _filter() {
    return Container(
        padding: const EdgeInsets.symmetric(
            vertical: kAppPaddingBetweenItemHorizontalSize));
  }

  // 3. Transaction list
  Widget _transactionItemsList() {
    return BlocConsumer<AuthenticatorBloc, AuthenticatorState>(
        builder: (context, state) => Expanded(
                child: Stack(children: [
              Positioned.fill(
                  child: _generateShadowTransactionItemsList(
                      state.transactionsList.length)),
              _generateTransactionItemsList(state.transactionsList)
            ])),
        listener: (context, state) {
          final getTransactionsListStatus = state.getTransactionListStatus;
          if (getTransactionsListStatus is RequestStatusFailed) {
            showSnackBar(
                context, getTransactionsListStatus.exception.toString());
          }
        });
  }

  Widget _generateTransactionItemsList(
      List<TransactionDetail> transactionsList) {
    final transactionWidgetsList = transactionsList
        .map<Widget>(
            (transactionDetail) => _generateTransactionItem(transactionDetail))
        .toList();
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (_, index) => transactionWidgetsList[index],
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: kAppPaddingBetweenItemHorizontalSize),
        itemCount: transactionWidgetsList.length);
  }

  Widget _generateTransactionItem(TransactionDetail transactionDetail) {
    final otpSessionInfo = transactionDetail.otpSessionInfo;
    return GestureDetector(
        onTap: () {
          Application.router.navigateTo(context, "/botp/transaction",
              routeSettings: RouteSettings(arguments: transactionDetail));
        },
        child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kAppPaddingHorizontalAndBottomSize),
            child: TransactionItemWidget(
                isNewest: false,
                agentName: otpSessionInfo.agentName,
                agentAvatarUrl: otpSessionInfo.agentAvatarUrl,
                agentIsVerified: otpSessionInfo.agentIsVerified,
                date: DateTime.fromMillisecondsSinceEpoch(
                        otpSessionInfo.timestamp)
                    .toString(),
                notifyMessage: otpSessionInfo.notifyMessage,
                transactionStatus: otpSessionInfo.transactionStatus)));
  }

  Widget _generateShadowTransactionItemsList(int transactionsListLength) {
    final shadowTransactionWidgetsList = List<Widget>.generate(
        transactionsListLength, (_) => _generateBoxShadow());
    return ListView.separated(
      itemBuilder: (_, index) => shadowTransactionWidgetsList[index],
      itemCount: shadowTransactionWidgetsList.length,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: kAppPaddingBetweenItemHorizontalSize),
    );
  }

  Widget _generateBoxShadow() => Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kAppPaddingHorizontalAndBottomSize),
      child: const ShadowTransactionItemWidget());
}
