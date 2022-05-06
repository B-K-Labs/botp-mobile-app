import 'package:botp_auth/common/models/authenticator_model.dart';
import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/routing_param.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/modules/botp/history/bloc/history_bloc.dart';
import 'package:botp_auth/modules/botp/history/bloc/history_event.dart';
import 'package:botp_auth/modules/botp/history/bloc/history_state.dart';
import 'package:botp_auth/modules/botp/home/cubit/botp_home_cubit.dart';
import 'package:botp_auth/modules/botp/home/cubit/botp_home_state.dart';
import 'package:botp_auth/utils/helpers/transaction.dart';
import 'package:botp_auth/utils/services/noti_api_service.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/filter.dart';
import 'package:botp_auth/widgets/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryBody extends StatefulWidget {
  const HistoryBody({Key? key}) : super(key: key);

  @override
  State<HistoryBody> createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HistoryBloc>(
        create: (context) => HistoryBloc(
            authenticatorRepository: context.read<AuthenticatorRepository>())
          ..add(HistoryEventGetTransactionsListAndSetupTimer()),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _searchSection(),
              _filterStatusSection(),
              _categorizedTransactionItemsList(),
            ]));
  }

  // 1. Reminder (no need)

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
                    validator: (_) {},
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
    return BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
      final _itemList = [
        {
          "type": ColorType.secondary,
          "status": TransactionStatus.succeeded,
          "onSelected": () {
            context.read<HistoryBloc>().add(
                HistoryEventTransactionStatusChanged(
                    transactionStatus: TransactionStatus.succeeded));
          },
          "hasNotification": state.categorizedSucceededTransactionsInfo
                  ?.isHavingNewTransactions ??
              false
        },
        {
          "type": ColorType.error,
          "status": TransactionStatus.failed,
          "onSelected": () {
            context.read<HistoryBloc>().add(
                HistoryEventTransactionStatusChanged(
                    transactionStatus: TransactionStatus.failed));
          },
          "hasNotification": state
                  .categorizedFailedTransactionsInfo?.isHavingNewTransactions ??
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
    return BlocConsumer<HistoryBloc, HistoryState>(builder: (context, state) {
      final categorizedTransactionsInfo =
          state.transactionStatus == TransactionStatus.succeeded
              ? state.categorizedSucceededTransactionsInfo
              : state.categorizedFailedTransactionsInfo;
      return categorizedTransactionsInfo != null
          ? (categorizedTransactionsInfo.isEmpty
              ? Expanded(
                  child: Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                ])))
              : Expanded(
                  child: NotificationListener<ScrollEndNotification>(
                      onNotification: (scrollEnd) {
                        final metrics = scrollEnd.metrics;
                        if (metrics.atEdge) {
                          bool isTop = metrics.pixels == 0;
                          if (!isTop) {
                            context
                                .read<HistoryBloc>()
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
                                .read<HistoryBloc>()
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
            // No need to clear transaction history
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
