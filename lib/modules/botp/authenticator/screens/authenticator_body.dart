import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/routing_param.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_bloc.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_event.dart';
import 'package:botp_auth/modules/botp/authenticator/bloc/authenticator_state.dart';
import 'package:botp_auth/modules/botp/home/cubit/botp_home_cubit.dart';
import 'package:botp_auth/modules/botp/home/cubit/botp_home_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/filter.dart';
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticatorBloc>(
        create: (context) => AuthenticatorBloc(
            authenticatorRepository: context.read<AuthenticatorRepository>())
          // https://stackoverflow.com/questions/62648103/triggering-initial-event-in-bloc
          ..add(AuthenticatorEventGetTransactionsListAndSetupTimer()),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _reminder(),
              _searchSection(),
              // _searchResult(),
              _transactionItemsList(),
            ]));
  }

  // 1. Reminder
  Widget _reminder() {
    return BlocBuilder<BOTPHomeCubit, BOTPHomeState>(builder: (context, state) {
      return state.loadUserDataStatus is LoadUserDataStatusSuccess
          ? (!state.didKyc!
              ? Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kAppPaddingHorizontalSize,
                      vertical: kAppPaddingBetweenItemSmallSize),
                  child: ReminderWidget(
                    iconData: Icons.verified,
                    colorType: ColorType.primary,
                    title: "You're almost done!",
                    description:
                        "BOTP Authenticator need to know you. Enter your information here to use the authenticator.",
                    onTap: () async {
                      final setUpKycResult = await Application.router
                              .navigateTo(
                                  context, "/botp/settings/account/setupKyc",
                                  routeSettings: const RouteSettings(
                                      arguments: FromScreen.botpAuthenticator))
                          as bool?;
                      if (setUpKycResult == true) {
                        showSnackBar(context, "Update profile successfully.",
                            SnackBarType.success);
                      }
                    },
                  ))
              : state.needRegisterAgent!
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kAppPaddingHorizontalSize,
                          vertical: kAppPaddingBetweenItemSmallSize),
                      child: ReminderWidget(
                        iconData: Icons.add_circle,
                        colorType: ColorType.secondary,
                        title: "Add your first agent!",
                        description:
                            "You currently have no registered agent. Start adding a new one now!",
                        onTap: () {
                          Application.router.navigateTo(
                              context, "/botp/settings/account/agentSetup");
                        },
                      ))
                  : Container())
          : Container();
    });
  }

  // // (History) 2. Search section
  // Widget _searchSection() {
  //   return Container(
  //       padding: const EdgeInsets.symmetric(
  //           horizontal: kAppPaddingHorizontalSize,
  //           vertical: kAppPaddingBetweenItemSmallSize),
  //       child: Column(children: [
  //         FieldNormalWidget(
  //             prefixIconData: Icons.search,
  //             hintText: "Agent name, agent address, notify message",
  //             validator: (_) {},
  //             onChanged: (_) {},
  //             textInputAction: TextInputAction.search),
  //         const SizedBox(height: kAppPaddingBetweenItemSmallSize),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             FilterTransactionStatusWidget(
  //                 onChanged: (value) {},
  //                 selectedValue: TransactionStatus.requesting),
  //             const SizedBox(width: kAppPaddingBetweenItemSmallSize),
  //             FilterTimeWidget(
  //               onChanged: (value) {},
  //               selectedValue: CommonTimeRange.lastDay,
  //             )
  //           ],
  //         )
  //       ]));
  // }

  // 2. Search section
  Widget _searchSection() {
    return BlocBuilder<AuthenticatorBloc, AuthenticatorState>(
        builder: (context, state) {
      final _itemList = [
        {
          "type": ColorType.normal,
          "status": TransactionStatus.all,
          "onSelected": () {
            context.read<AuthenticatorBloc>().add(
                AuthenticatorEventGetTransactionsListAndSetupTimer(
                    transactionStatus: TransactionStatus.all));
          }
        },
        {
          "type": ColorType.tertiary,
          "status": TransactionStatus.requesting,
          "onSelected": () {
            context.read<AuthenticatorBloc>().add(
                AuthenticatorEventGetTransactionsListAndSetupTimer(
                    transactionStatus: TransactionStatus.requesting));
          }
        },
        {
          "type": ColorType.primary,
          "status": TransactionStatus.waiting,
          "onSelected": () {
            context.read<AuthenticatorBloc>().add(
                AuthenticatorEventGetTransactionsListAndSetupTimer(
                    transactionStatus: TransactionStatus.waiting));
          }
        }
      ];
      return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kAppPaddingHorizontalSize,
              vertical: kAppPaddingBetweenItemSmallSize),
          child: Wrap(
              direction: Axis.horizontal,
              children: List.generate(
                  _itemList.length,
                  (index) => Container(
                      margin: const EdgeInsets.only(right: 6.0),
                      child: FilterTransactionStatusWidget(
                          transactionStatus:
                              _itemList[index]["status"] as TransactionStatus,
                          colorType: _itemList[index]["type"] as ColorType,
                          isSelected:
                              _itemList[index]["status"] as TransactionStatus ==
                                  state.transactionStatus,
                          onSelected: _itemList[index]["onSelected"]
                              as VoidCallback?)))));
    });
  }

  // // 3. Search result
  // Widget _searchResult() {
  //   return Container(
  //       padding:
  //           const EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize),
  //       child: Column(children: [
  //         Row(children: [
  //           const Text("You have 123 transactions to authenticate")
  //         ]),
  //         const SizedBox(height: kAppPaddingBetweenItemSmallSize)
  //       ]));
  // }

  // 4. Transaction list
  // Two scrollable: https://www.youtube.com/watch?v=8T7hetwuwY4
  Widget _transactionItemsList() {
    // return Container();
    return BlocConsumer<AuthenticatorBloc, AuthenticatorState>(
        builder: (context, state) {
      final transactionsList = state.transactionsList;
      return transactionsList != null
          ? (transactionsList.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: kAppPaddingBetweenItemLargeSize),
                  child: Center(
                      child: Text("You don't have any transactions.",
                          style: Theme.of(context).textTheme.bodyText2)))
              : Expanded(
                  child: NotificationListener<ScrollEndNotification>(
                      onNotification: (scrollEnd) {
                        final metrics = scrollEnd.metrics;
                        if (metrics.atEdge) {
                          bool isTop = metrics.pixels == 0;
                          if (!isTop) {
                            context
                                .read<AuthenticatorBloc>()
                                .refreshTransactionsList(needMorePage: true);
                            return true;
                          }
                        }
                        return true;
                      },
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
                          }))))
          : Container(
              padding: const EdgeInsets.symmetric(
                  vertical: kAppPaddingBetweenItemNormalSize,
                  horizontal: kAppPaddingHorizontalSize),
              child: Column(children: const [
                TransactionItemSkeletonWidget(),
                SizedBox(height: kAppPaddingBetweenItemSmallSize),
                TransactionItemSkeletonWidget()
              ]));
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
            vertical: kAppPaddingBetweenItemNormalSize),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
        child: TransactionItemWidget(
          isNewest: false,
          agentName: otpSessionInfo.agentName,
          agentAvatarUrl: otpSessionInfo.agentAvatarUrl,
          agentIsVerified: otpSessionInfo.agentIsVerified,
          timestamp: otpSessionInfo.timestamp,
          notifyMessage: otpSessionInfo.notifyMessage,
          transactionStatus: otpSessionInfo.transactionStatus,
          onTap: () {
            Application.router.navigateTo(context, "/botp/transaction",
                routeSettings: RouteSettings(arguments: transactionDetail));
          },
        ));
  }

  Widget _generateShadowTransactionItemsList(int transactionsListLength) {
    final shadowTransactionWidgetsList = List<Widget>.generate(
        transactionsListLength, (_) => _generateShadowTransactionItem());
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
          vertical: kAppPaddingBetweenItemNormalSize),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
