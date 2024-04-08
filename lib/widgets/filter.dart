import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/transaction.dart';
import "package:flutter/material.dart";

class FilterTransactionStatus2Widget extends StatelessWidget {
  final TransactionStatus selectedValue;
  final ValueChanged<TransactionStatus?>? onChanged;

  const FilterTransactionStatus2Widget(
      {Key? key, required this.selectedValue, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dropdown Theme
    // - Color
    final color = Theme.of(context).colorScheme.surface;
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kAppPaddingBetweenItemSmallSize),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        child: DropdownButton<TransactionStatus>(
          value: selectedValue,
          onChanged: onChanged,
          dropdownColor: color,
          icon: const Icon(Icons.arrow_drop_down),
          // iconSize: 24,
          underline: const SizedBox(),
          items: [
            DropdownMenuItem(
                value: TransactionStatus.requesting,
                child: Text(TransactionStatus.requesting.toCapitalizedString(),
                    style: Theme.of(context).textTheme.bodyMedium)),
            DropdownMenuItem(
                value: TransactionStatus.waiting,
                child: Text(TransactionStatus.waiting.toCapitalizedString(),
                    style: Theme.of(context).textTheme.bodyMedium))
          ],
        ));
  }
}

class FilterTime2Widget extends StatelessWidget {
  final CommonTimeRange selectedValue;
  final ValueChanged<CommonTimeRange?>? onChanged;

  const FilterTime2Widget(
      {Key? key, required this.selectedValue, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dropdown Theme
    // - Color
    final color = Theme.of(context).colorScheme.surface;
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kAppPaddingBetweenItemSmallSize),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        child: DropdownButton<CommonTimeRange>(
          value: selectedValue,
          onChanged: onChanged,
          dropdownColor: color,
          icon: const Icon(Icons.arrow_drop_down),
          // iconSize: 24,
          underline: const SizedBox(),
          items: [
            DropdownMenuItem(
                value: CommonTimeRange.all,
                child:
                    Text("All", style: Theme.of(context).textTheme.bodyMedium)),
            DropdownMenuItem(
                value: CommonTimeRange.lastDay,
                child: Text("Last day",
                    style: Theme.of(context).textTheme.bodyMedium)),
            DropdownMenuItem(
                value: CommonTimeRange.lastWeek,
                child: Text("Last week",
                    style: Theme.of(context).textTheme.bodyMedium)),
            DropdownMenuItem(
                value: CommonTimeRange.lastMonth,
                child: Text("Last month",
                    style: Theme.of(context).textTheme.bodyMedium)),
            DropdownMenuItem(
                value: CommonTimeRange.customRange,
                child: Text("Pick a range ...",
                    style: Theme.of(context).textTheme.bodyMedium))
          ],
        ));
  }
}

class FilterTransactionStatusWidget extends StatelessWidget {
  final TransactionStatus transactionStatus;
  final bool hasNewNotification;
  final ColorType colorType;
  final bool isSelected;
  final VoidCallback? onSelected;

  const FilterTransactionStatusWidget(
      {Key? key,
      required this.transactionStatus,
      required this.colorType,
      required this.isSelected,
      required this.onSelected,
      this.hasNewNotification = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Transaction Status Filter Theme
    // - Colors
    final Color primary;
    final Color? backgroundColor;
    if (isSelected) {
      switch (colorType) {
        case ColorType.secondary:
          primary = Theme.of(context).colorScheme.onSecondaryContainer;
          backgroundColor = Theme.of(context).colorScheme.secondaryContainer;
          break;
        case ColorType.tertiary:
          primary = Theme.of(context).colorScheme.onTertiaryContainer;
          backgroundColor = Theme.of(context).colorScheme.tertiaryContainer;
          break;
        case ColorType.error:
          primary = Theme.of(context).colorScheme.onErrorContainer;
          backgroundColor = Theme.of(context).colorScheme.errorContainer;
          break;
        case ColorType.normal:
          primary = Theme.of(context).colorScheme.onSurfaceVariant;
          backgroundColor = Theme.of(context).colorScheme.surfaceVariant;
          break;
        case ColorType.primary:
        default:
          primary = Theme.of(context).colorScheme.onPrimaryContainer;
          backgroundColor = Theme.of(context).colorScheme.primaryContainer;
          break;
      }
    } else {
      primary = Theme.of(context).colorScheme.onSurface;
      backgroundColor = null;
    }

    // - Font
    TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: primary,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal);
    // - Padding
    const padding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
    // - Decoration
    final borderRadius = BorderRadius.circular(100);
    final decoration =
        BoxDecoration(color: backgroundColor, borderRadius: borderRadius);

    return Stack(children: [
      FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
              decoration: decoration,
              child: Material(
                  color: Colors.transparent,
                  borderRadius: borderRadius,
                  child: InkWell(
                      onTap: onSelected,
                      borderRadius: borderRadius,
                      child: Container(
                          padding: padding,
                          child: Text(transactionStatus.toCapitalizedString(),
                              style: textStyle)))))),
      Positioned(
          top: 0,
          right: 0,
          child: hasNewNotification
              ? Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      borderRadius: BorderRadius.circular(100)),
                  child: const SizedBox(height: 8.0, width: 8.0))
              : Container())
    ]);
  }
}
