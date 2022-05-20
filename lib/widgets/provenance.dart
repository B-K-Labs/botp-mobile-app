import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import "package:flutter/material.dart";

class BroadcastEventDetailWidget extends StatelessWidget {
  final BroadcastEventData? data;
  final void Function(String, String) opTapCopyData;

  const BroadcastEventDetailWidget(
      {Key? key, required this.data, required this.opTapCopyData})
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
                              opTapCopyData("Agent blockchain address",
                                  data!.agentBcAddress);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("User address", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.userBcAddress,
                            onTap: () {
                              opTapCopyData("User blockchain address",
                                  data!.userBcAddress);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Id", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.id,
                            onTap: () {
                              opTapCopyData("Id", data!.id);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Encrypted message", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.encryptedMessage,
                            onTap: () {
                              opTapCopyData(
                                  "Encrypted message", data!.encryptedMessage);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                    _provenanceEventDetailTextLineWidget(
                        Container(),
                        ButtonTextWidget(
                            text: "Scan on Blockchain Explorer",
                            onPressed: () {}))
                  ])
                : const Text("Data is not found"),
          ],
        ));
  }
}

class HistoryEventDetailWidget extends StatelessWidget {
  final HistoryEventData? data;
  final void Function(String, String) opTapCopyData;

  const HistoryEventDetailWidget(
      {Key? key, required this.data, required this.opTapCopyData})
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
                              opTapCopyData("Agent blockchain address",
                                  data!.agentBcAddress);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("User address", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.userBcAddress,
                            onTap: () {
                              opTapCopyData("User blockchain address",
                                  data!.userBcAddress);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Id", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.id,
                            onTap: () {
                              opTapCopyData("Id", data!.id);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Encrypted message", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.encryptedMessage,
                            onTap: () {
                              opTapCopyData(
                                  "Encrypted message", data!.encryptedMessage);
                            })),
                    const DividerWidget(),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Signature", style: _labelStyle),
                        BcAddressWidget(
                            bcAddress: data!.signature,
                            onTap: () {
                              opTapCopyData("Signature", data!.signature);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                    _provenanceEventDetailTextLineWidget(
                        Container(),
                        ButtonTextWidget(
                            text: "Scan on Blockchain Explorer",
                            onPressed: () {}))
                  ])
                : const Text("Data is not found"),
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
    final _matchedStatus =
        Column(children: [Text("All information is matched.")]);
    final _unmatchedStatus =
        Column(children: [Text("Some information is unmatched.")]);
    return isMatched ? _matchedStatus : _unmatchedStatus;
  }
}
