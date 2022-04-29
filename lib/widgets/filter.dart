import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/transaction.dart';
import "package:flutter/material.dart";

class FilterTransactionStatusWidget extends StatelessWidget {
  final TransactionStatus selectedValue;
  final ValueChanged<TransactionStatus?>? onChanged;

  const FilterTransactionStatusWidget(
      {Key? key, required this.selectedValue, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dropdown Theme
    // - Color
    final _color = Theme.of(context).colorScheme.surface;
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kAppPaddingBetweenItemSmallSize),
        decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        child: DropdownButton<TransactionStatus>(
          value: selectedValue,
          onChanged: onChanged,
          dropdownColor: _color,
          icon: Icon(Icons.arrow_drop_down),
          // iconSize: 24,
          underline: SizedBox(),
          items: [
            DropdownMenuItem(
                child: Text(TransactionStatus.requesting.toCapitalizedString(),
                    style: Theme.of(context).textTheme.bodyText2),
                value: TransactionStatus.requesting),
            DropdownMenuItem(
                child: Text(TransactionStatus.waiting.toCapitalizedString(),
                    style: Theme.of(context).textTheme.bodyText2),
                value: TransactionStatus.waiting)
          ],
        ));
  }
}

class FilterTimeWidget extends StatelessWidget {
  final CommonTimeRange selectedValue;
  final ValueChanged<CommonTimeRange?>? onChanged;

  const FilterTimeWidget(
      {Key? key, required this.selectedValue, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dropdown Theme
    // - Color
    final _color = Theme.of(context).colorScheme.surface;
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kAppPaddingBetweenItemSmallSize),
        decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        child: DropdownButton<CommonTimeRange>(
          value: selectedValue,
          onChanged: onChanged,
          dropdownColor: _color,
          icon: Icon(Icons.arrow_drop_down),
          // iconSize: 24,
          underline: SizedBox(),
          items: [
            DropdownMenuItem(
                child:
                    Text("All", style: Theme.of(context).textTheme.bodyText2),
                value: CommonTimeRange.all),
            DropdownMenuItem(
                child: Text("Last day",
                    style: Theme.of(context).textTheme.bodyText2),
                value: CommonTimeRange.lastDay),
            DropdownMenuItem(
                child: Text("Last week",
                    style: Theme.of(context).textTheme.bodyText2),
                value: CommonTimeRange.lastWeek),
            DropdownMenuItem(
                child: Text("Last month",
                    style: Theme.of(context).textTheme.bodyText2),
                value: CommonTimeRange.lastMonth),
            DropdownMenuItem(
                child: Text("Pick a range ...",
                    style: Theme.of(context).textTheme.bodyText2),
                value: CommonTimeRange.customRange)
          ],
        ));
  }
}
