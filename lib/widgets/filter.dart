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
    final Color _primary;
    final Color? _backgroundColor;
    if (isSelected) {
      switch (colorType) {
        case ColorType.secondary:
          _primary = Theme.of(context).colorScheme.onSecondaryContainer;
          _backgroundColor = Theme.of(context).colorScheme.secondaryContainer;
          break;
        case ColorType.tertiary:
          _primary = Theme.of(context).colorScheme.onTertiaryContainer;
          _backgroundColor = Theme.of(context).colorScheme.tertiaryContainer;
          break;
        case ColorType.error:
          _primary = Theme.of(context).colorScheme.onErrorContainer;
          _backgroundColor = Theme.of(context).colorScheme.errorContainer;
          break;
        case ColorType.normal:
          _primary = Theme.of(context).colorScheme.onSurfaceVariant;
          _backgroundColor = Theme.of(context).colorScheme.surfaceVariant;
          break;
        case ColorType.primary:
        default:
          _primary = Theme.of(context).colorScheme.onPrimaryContainer;
          _backgroundColor = Theme.of(context).colorScheme.primaryContainer;
          break;
      }
    } else {
      _primary = Theme.of(context).colorScheme.onSurface;
      _backgroundColor = null;
    }

    // - Font
    TextStyle? _textStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
        color: _primary,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal);
    // - Padding
    const _padding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
    // - Decoration
    final _borderRadius = BorderRadius.circular(100);
    final _decoration =
        BoxDecoration(color: _backgroundColor, borderRadius: _borderRadius);

    return Stack(children: [
      FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
              decoration: _decoration,
              child: Material(
                  color: Colors.transparent,
                  borderRadius: _borderRadius,
                  child: InkWell(
                      onTap: onSelected,
                      borderRadius: _borderRadius,
                      child: Container(
                          padding: _padding,
                          child: Text(transactionStatus.toCapitalizedString(),
                              style: _textStyle)))))),
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
