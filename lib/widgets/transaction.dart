import 'package:botp_auth/constants/app_constants.dart';
import 'package:flutter/material.dart';

class TransactionStatusWidget extends StatelessWidget {
  final int status;
  const TransactionStatusWidget({Key? key, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _statusString = status == 0
        ? 'Pending'
        : status == 1
            ? 'Confirmed'
            : status == 2
                ? 'Rejected'
                : 'Expired';
    Color _color = status == 0
        ? AppColors.primaryColor
        : status == 1
            ? AppColors.greenColor
            : status == 2
                ? AppColors.redColor
                : AppColors.grayColor04;
    return Container(
      decoration: BoxDecoration(
          color: _color,
          border: Border.all(color: _color, width: 1.0),
          borderRadius: BorderRadius.circular(AppBorderRadiusCircular.small)),
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
      child: Text(_statusString,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: AppColors.whiteColor)),
    );
  }
}

// Transaction Item (auth page)
class TransactionItemWidget extends StatefulWidget {
  final bool isLasted;
  final String agentName;
  final String timestamp;
  final String email;
  final String urlImage;
  final int transStatus;
  const TransactionItemWidget(
      {Key? key,
      required this.isLasted,
      required this.agentName,
      required this.timestamp,
      required this.email,
      required this.urlImage,
      required this.transStatus})
      : super(key: key);

  @override
  _TransactionItemWidgetState createState() => _TransactionItemWidgetState();
}

class _TransactionItemWidgetState extends State<TransactionItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppBorderRadiusCircular.medium),
          border: widget.isLasted
              ? Border.all(color: AppColors.grayColor04, width: 1.0)
              : null,
        ),
        height: 94,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0),
                child: SizedBox(
                  height: 62.0,
                  width: 62.0,
                  child: Image.network(widget.urlImage,
                      scale: 1, fit: BoxFit.fitWidth),
                )),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 16.0),
                    Text(
                      widget.agentName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      widget.timestamp,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: AppColors.grayColor04),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      widget.email,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: AppColors.grayColor04),
                    ),
                  ],
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 0.0),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20.0),
                    child: TransactionStatusWidget(status: widget.transStatus))
              ],
            )
          ],
        ));
  }
}
