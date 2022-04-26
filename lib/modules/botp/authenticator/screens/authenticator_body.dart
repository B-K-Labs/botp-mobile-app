import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_bloc.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_event.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/transaction.dart';
import 'package:flutter/cupertino.dart';
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
          ..add(AuthenticatorEventGetTransactionsListAndSetupTimer()),
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
        padding:
            const EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize),
      );
    });
  }

  // 2. Transaction filter
  Widget _filter() {
    return Container(
        padding: const EdgeInsets.symmetric(
            vertical: kAppPaddingBetweenItemSmallSize));
  }

  // 3. Transaction list
  // Two scrollable: https://www.youtube.com/watch?v=8T7hetwuwY4
  Widget _transactionItemsList() {
    return BlocConsumer<AuthenticatorBloc, AuthenticatorState>(
        builder: (context, state) {
      final transactionsList = state.transactionsList;
      return transactionsList != null
          ? Expanded(
              child: RefreshIndicator(
                  // Scroll double list view
                  // 1. Use it as a parent
                  // 2. Disable physical scrollable for all list views
                  child: SingleChildScrollView(
                      child: Column(children: [
                    Stack(children: [
                      _generateShadowTransactionItemsList(
                          transactionsList.length),
                      _generateTransactionItemsList(transactionsList)
                    ])
                  ])),
                  onRefresh: () async {
                    await context
                        .read<AuthenticatorBloc>()
                        .refreshTransactionsList();
                  }))
          : Container();
    }, listener: (context, state) {
      final getTransactionsListStatus = state.getTransactionListStatus;
      if (getTransactionsListStatus is RequestStatusFailed) {
        showSnackBar(context, getTransactionsListStatus.exception.toString());
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
        padding: const EdgeInsets.symmetric(
            vertical: kAppPaddingBetweenItemSmallSize),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => transactionWidgetsList[index],
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
        itemCount: transactionWidgetsList.length);
  }

  Widget _generateTransactionItem(TransactionDetail transactionDetail) {
    final otpSessionInfo = transactionDetail.otpSessionInfo;
    return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize),
        child: GestureDetector(
            onTap: () {
              Application.router.navigateTo(context, "/botp/transaction",
                  routeSettings: RouteSettings(arguments: transactionDetail));
            },
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
        transactionsListLength, (_) => _generateShadowTransactionItem());
    return ListView.separated(
      padding:
          const EdgeInsets.symmetric(vertical: kAppPaddingBetweenItemSmallSize),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) => shadowTransactionWidgetsList[index],
      itemCount: shadowTransactionWidgetsList.length,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: kAppPaddingBetweenItemSmallSize),
    );
  }

  Widget _generateShadowTransactionItem() => Container(
      padding:
          const EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize),
      child: const ShadowTransactionItemWidget());
}
