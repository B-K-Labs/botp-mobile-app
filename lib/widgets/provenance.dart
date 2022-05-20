import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import "package:flutter/material.dart";

class BroadcastEventDetailWidget extends StatelessWidget {
  final BroadcastEventData? data;
  final void Function(String, String) onTapCopyData;
  final void Function(String) onTapScanExplorer;

  const BroadcastEventDetailWidget(
      {Key? key,
      required this.data,
      required this.onTapCopyData,
      required this.onTapScanExplorer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Theme
    final _headlineStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontWeight: FontWeight.bold);
    final _labelStyle = Theme.of(context).textTheme.bodyText2;

    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.outline, width: 1.0),
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Broadcast event", style: _headlineStyle),
            data != null
                ? Column(children: [
                    const SizedBox(height: 18.0),
                    _provenanceEventDetailTextLineWidget(
                        Text("Agent address", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.agentBcAddress,
                            onTap: () {
                              onTapCopyData("Agent blockchain address",
                                  data!.agentBcAddress);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("User address", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.userBcAddress,
                            onTap: () {
                              onTapCopyData("User blockchain address",
                                  data!.userBcAddress);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Id", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.id,
                            onTap: () {
                              onTapCopyData("Id", data!.id);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Encrypted message", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.encryptedMessage,
                            onTap: () {
                              onTapCopyData(
                                  "Encrypted message", data!.encryptedMessage);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                    _provenanceEventDetailTextLineWidget(
                        Container(),
                        ButtonTextWidget(
                            text: "Scan on Blockchain Explorer",
                            onPressed: () {
                              onTapScanExplorer(data!.explorerId);
                            }))
                  ])
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                        SizedBox(height: kAppPaddingBetweenItemLargeSize),
                        Center(child: Text("Data is not found")),
                        SizedBox(height: kAppPaddingBetweenItemNormalSize)
                      ]),
          ],
        ));
  }
}

class HistoryEventDetailWidget extends StatelessWidget {
  final HistoryEventData? data;
  final void Function(String, String) onTapCopyData;
  final void Function(String) onTapScanExplorer;

  const HistoryEventDetailWidget(
      {Key? key,
      required this.data,
      required this.onTapCopyData,
      required this.onTapScanExplorer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Theme
    final _headlineStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontWeight: FontWeight.bold);
    final _labelStyle = Theme.of(context).textTheme.bodyText2;

    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.outline, width: 1.0),
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("History event", style: _headlineStyle),
            data != null
                ? Column(children: [
                    const SizedBox(height: 18.0),
                    _provenanceEventDetailTextLineWidget(
                        Text("Agent address", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.agentBcAddress,
                            onTap: () {
                              onTapCopyData("Agent blockchain address",
                                  data!.agentBcAddress);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("User address", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.userBcAddress,
                            onTap: () {
                              onTapCopyData("User blockchain address",
                                  data!.userBcAddress);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Id", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.id,
                            onTap: () {
                              onTapCopyData("Id", data!.id);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Encrypted message", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.encryptedMessage,
                            onTap: () {
                              onTapCopyData(
                                  "Encrypted message", data!.encryptedMessage);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    const DividerWidget(),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Signature", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.signature,
                            onTap: () {
                              onTapCopyData("Signature", data!.signature);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                    _provenanceEventDetailTextLineWidget(
                        Container(),
                        ButtonTextWidget(
                            text: "Scan on Blockchain Explorer",
                            onPressed: () {
                              onTapScanExplorer(data!.explorerId);
                            }))
                  ])
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                        SizedBox(height: kAppPaddingBetweenItemLargeSize),
                        Center(child: Text("Data is not found")),
                        SizedBox(height: kAppPaddingBetweenItemNormalSize)
                      ]),
          ],
        ));
  }
}

Widget _provenanceEventDetailTextLineWidget(Widget label, Widget? value) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: value != null ? [label, value] : [Expanded(child: label)]);
}

class ProvenanceStatusWidget extends StatelessWidget {
  final bool isMatched;
  const ProvenanceStatusWidget({Key? key, required this.isMatched})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Theme
    final Color _color = isMatched
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.error;
    final TextStyle? _titleStyle =
        Theme.of(context).textTheme.headline5?.copyWith(color: _color);
    final TextStyle? _textStyle = Theme.of(context).textTheme.bodyText2;

    final _matchedStatus = Column(children: [
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      SizedBox(
        height: 80.0,
        width: 80.0,
        child: Image.asset("assets/images/status/status_success.png",
            scale: 1, fit: BoxFit.contain),
      ),
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      Text("Matched events", style: _titleStyle),
      const SizedBox(height: kAppPaddingBetweenItemSmallSize),
      Text("All information between two events is matched.", style: _textStyle),
    ]);
    final _unmatchedStatus = Column(children: [
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      SizedBox(
        height: 80.0,
        width: 80.0,
        child: Image.asset("assets/images/status/status_failed.png",
            scale: 1, fit: BoxFit.contain),
      ),
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      Text("Unmatched events", style: _titleStyle),
      const SizedBox(height: kAppPaddingBetweenItemSmallSize),
      Text("Exists unmatched information between two events.",
          style: _textStyle),
    ]);
    return isMatched ? _matchedStatus : _unmatchedStatus;
  }
}
