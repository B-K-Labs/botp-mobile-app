import 'package:botp_auth/common/models/authenticator_model.dart';
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
import 'package:botp_auth/utils/helpers/transaction.dart';
import 'package:botp_auth/utils/services/notifications_service.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/filter.dart';
import 'package:botp_auth/widgets/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

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
              _filterStatusSection(),
              _categorizedTransactionItemsList(),
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

  // 2. Search section
  Widget _searchSection() {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kAppPaddingHorizontalSize,
            vertical: kAppPaddingBetweenItemSmallSize),
        child: Column(children: [
          Row(children: [
            Expanded(
                child: FieldNormalWidget(
                    prefixIconData: Icons.search,
                    hintText: "Agent name, agent address, notify message",
                    validator: (_) => null,
                    onChanged: (_) {},
                    textInputAction: TextInputAction.search)),
            const SizedBox(width: kAppPaddingBetweenItemSmallSize),
            FilterTime2Widget(
              onChanged: (value) {},
              selectedValue: CommonTimeRange.lastDay,
            ),
          ])
        ]));
  }

  // 3. Filter status section
  Widget _filterStatusSection() {
    return BlocConsumer<AuthenticatorBloc, AuthenticatorState>(
        listener: (context, state) {
      final List<String> notifiedRequestingTransactionsList =
          state.notifiedRequestingTransactionsList;
      final List<String> notifiedWaitingTransactionsList =
          state.notifiedWaitingTransactionsList;
      if (notifiedRequestingTransactionsList.isNotEmpty ||
          notifiedWaitingTransactionsList.isNotEmpty) {
        // Show notification
        const title = "New transactions to authenticate";
        final String body = getBodyPushNotificationMessage(
            notifiedRequestingTransactionsList,
            notifiedWaitingTransactionsList);
        NotificationApi.showBigTextNotification(title: title, bigText: body);
      }
    }, builder: (context, state) {
      final _itemList = [
        {
          "type": ColorType.tertiary,
          "status": TransactionStatus.requesting,
          "onSelected": () {
            context.read<AuthenticatorBloc>().add(
                AuthenticatorEventTransactionStatusChanged(
                    transactionStatus: TransactionStatus.requesting));
          },
          "hasNotification": state.categorizedRequestingTransactionsInfo
                  ?.isHavingNewTransactions ??
              false
        },
        {
          "type": ColorType.primary,
          "status": TransactionStatus.waiting,
          "onSelected": () {
            context.read<AuthenticatorBloc>().add(
                AuthenticatorEventTransactionStatusChanged(
                    transactionStatus: TransactionStatus.waiting));
          },
          "hasNotification": state.categorizedWaitingTransactionsInfo
                  ?.isHavingNewTransactions ??
              false
        }
      ];
      return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kAppPaddingHorizontalSize,
              vertical: kAppPaddingBetweenItemSmallSize),
          child: Center(
              child: Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(_itemList.length, (index) {
                    final filterItem = _itemList[index];
                    return Container(
                        margin: const EdgeInsets.only(right: 6.0),
                        child: FilterTransactionStatusWidget(
                          transactionStatus:
                              filterItem["status"] as TransactionStatus,
                          colorType: filterItem["type"] as ColorType,
                          isSelected:
                              filterItem["status"] as TransactionStatus ==
                                  state.transactionStatus,
                          onSelected: filterItem["onSelected"] as VoidCallback?,
                          hasNewNotification:
                              filterItem["hasNotification"] as bool,
                        ));
                  }))));
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

  Widget _categorizedTransactionItemsList() {
    return BlocConsumer<AuthenticatorBloc, AuthenticatorState>(
        builder: (context, state) {
      final categorizedTransactionsInfo =
          state.transactionStatus == TransactionStatus.requesting
              ? state.categorizedRequestingTransactionsInfo
              : state.categorizedWaitingTransactionsInfo;
      return categorizedTransactionsInfo != null
          ? (categorizedTransactionsInfo.isEmpty
              ? Expanded(
                  child: Center(
                      child: SingleChildScrollView(
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    height: 80.0,
                    width: 80.0,
                    child: Image.asset(
                        "assets/images/logo/botp_logo_disabled.png",
                        scale: 1,
                        fit: BoxFit.contain),
                  ),
                  const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                  Text("You don't have any transactions.",
                      style: Theme.of(context).textTheme.caption)
                ]))))
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
                            _generateCategorizedTransactionItemsList(
                                context,
                                categorizedTransactionsInfo
                                    .categorizedTransactions),
                          ])),
                          onRefresh: () async {
                            await context
                                .read<AuthenticatorBloc>()
                                .refreshTransactionsList();
                          }))))
          : Expanded(
              child: SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: kAppPaddingBetweenItemSmallSize,
                          horizontal: kAppPaddingHorizontalSize),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(children: const [
                              SizedBox(width: 16.0),
                              Expanded(
                                  child: SkeletonLine(
                                      style: SkeletonLineStyle(
                                          randomLength: true,
                                          minLength: 75,
                                          maxLength: 150,
                                          height: 16.0,
                                          alignment: Alignment.centerLeft)))
                            ]),
                            const SizedBox(
                                height: kAppPaddingBetweenItemNormalSize),
                            const TransactionItemSkeletonWidget(),
                            const SizedBox(
                                height: kAppPaddingBetweenItemSmallSize),
                            const TransactionItemSkeletonWidget()
                          ]))));
    }, listener: (context, state) {
      final getTransactionsListStatus = state.getTransactionListStatus;
      if (getTransactionsListStatus is RequestStatusFailed) {
        showSnackBar(context, getTransactionsListStatus.exception.toString());
      }
    });
  }

  Widget _generateCategorizedTransactionItemsList(BuildContext context,
      List<CategorizedTransactions> categorizedTransactionsItemsList) {
    final categorizedTransactionWidgetsList = categorizedTransactionsItemsList
        .map<Widget>((categorizedTransactions) =>
            _generateCategorizedTransactionItems(
                context, categorizedTransactions))
        .toList();
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => categorizedTransactionWidgetsList[index],
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
        itemCount: categorizedTransactionWidgetsList.length);
  }

  Widget _generateCategorizedTransactionItems(
      BuildContext context, CategorizedTransactions categorizedTransactions) {
    // Categorized theme
    // - Color
    final Color primary =
        categorizedTransactions.categoryType == TimeFilters.newest
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.onSurface;

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kAppPaddingHorizontalSize,
              vertical: kAppPaddingBetweenItemSmallSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Icon(Icons.date_range, color: primary),
              const SizedBox(width: 16.0),
              Text(
                  categorizedTransactions.categoryName +
                      " (${categorizedTransactions.transactionsList.length})",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: primary, fontWeight: FontWeight.bold))
            ],
          )),
      // const SizedBox(height: 12.0),
      _transactionItemsList(context, categorizedTransactions.transactionsList)
    ]);
  }

  Widget _transactionItemsList(
      BuildContext context, List<TransactionDetail> transactionsList) {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          Stack(children: [
            _generateShadowTransactionItemsList(transactionsList.length),
            _generateTransactionItemsList(context, transactionsList)
          ])
        ]));
  }

  Widget _generateTransactionItemsList(
      BuildContext context, List<TransactionDetail> transactionsList) {
    final transactionWidgetsList = transactionsList
        .map<Widget>((transactionDetail) =>
            _generateTransactionItem(context, transactionDetail))
        .toList();
    return ListView.separated(
        padding: const EdgeInsets.symmetric(
            vertical: kAppPaddingBetweenItemSmallSize),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => transactionWidgetsList[index],
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
        itemCount: transactionWidgetsList.length);
  }

  Widget _generateTransactionItem(
      BuildContext context, TransactionDetail transactionDetail) {
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
            // Clear history for that transaction
            context.read<AuthenticatorBloc>().add(
                AuthenticatorEventRemoveTransactionHistory(
                    transactionSecretId:
                        transactionDetail.otpSessionSecretInfo.secretId,
                    transactionStatus:
                        transactionDetail.otpSessionInfo.transactionStatus));
            Application.router.navigateTo(context, "/botp/transaction",
                routeSettings: RouteSettings(arguments: transactionDetail));
          },
        ));
  }

  Widget _generateShadowTransactionItemsList(int transactionsListLength) {
    final shadowTransactionWidgetsList = List<Widget>.generate(
        transactionsListLength, (_) => _generateShadowTransactionItem());
    return ListView.separated(
      padding:
          const EdgeInsets.symmetric(vertical: kAppPaddingBetweenItemSmallSize),
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
