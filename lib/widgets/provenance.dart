import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import "package:flutter/material.dart";

class BroadcastEventDetailWidget extends StatelessWidget {
  final BroadcastEventData? data;
  final ProvenanceMatchingInfo matchingInfo;
  final void Function(String, String) onTapCopyData;
  final void Function(String) onTapScanExplorer;

  const BroadcastEventDetailWidget(
      {Key? key,
      required this.data,
      required this.matchingInfo,
      required this.onTapCopyData,
      required this.onTapScanExplorer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Theme
    // - Color
    final Color matchedColor = Theme.of(context).colorScheme.secondary;
    final Color unmatchedColor = Theme.of(context).colorScheme.error;
    // - Text
    final headlineStyle = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(fontWeight: FontWeight.bold);
    final labelStyle = Theme.of(context).textTheme.bodyMedium;
    genLabelStyle(bool isMatched) => labelStyle?.copyWith(
        color: isMatched ? matchedColor : unmatchedColor);

    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.outline, width: 1.0),
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Broadcast event", style: headlineStyle),
            data != null
                ? Column(children: [
                    const SizedBox(height: 18.0),
                    _provenanceEventDetailTextLineWidget(
                        Text("Agent address",
                            style: genLabelStyle(matchingInfo.agentBcAddress)),
                        BcAddressWidget(
                            bcAddress: data!.agentBcAddress,
                            onTap: () {
                              onTapCopyData("Agent blockchain address",
                                  data!.agentBcAddress);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("User address",
                            style: genLabelStyle(matchingInfo.userBcAddress)),
                        BcAddressWidget(
                            bcAddress: data!.userBcAddress,
                            onTap: () {
                              onTapCopyData("User blockchain address",
                                  data!.userBcAddress);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Id", style: genLabelStyle(matchingInfo.id)),
                        BcAddressWidget(
                            bcAddress: data!.id,
                            onTap: () {
                              onTapCopyData("Id", data!.id);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Encrypted message",
                            style:
                                genLabelStyle(matchingInfo.encryptedMessage)),
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
                            iconData: Icons.launch,
                            onPressed: () {
                              onTapScanExplorer(data!.explorerId);
                            }))
                  ])
                : const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
  final ProvenanceMatchingInfo matchingInfo;
  final void Function(String, String) onTapCopyData;
  final void Function(String) onTapScanExplorer;

  const HistoryEventDetailWidget(
      {Key? key,
      required this.data,
      required this.matchingInfo,
      required this.onTapCopyData,
      required this.onTapScanExplorer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Theme
    // - Color
    final Color matchedColor = Theme.of(context).colorScheme.secondary;
    final Color unmatchedColor = Theme.of(context).colorScheme.error;
    // - Text
    final headlineStyle = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(fontWeight: FontWeight.bold);
    final labelStyle = Theme.of(context).textTheme.bodyMedium;
    genLabelStyle(bool isMatched) => labelStyle?.copyWith(
        color: isMatched ? matchedColor : unmatchedColor);

    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.outline, width: 1.0),
            borderRadius: BorderRadius.circular(BorderRadiusSize.normal)),
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("History event", style: headlineStyle),
            data != null
                ? Column(children: [
                    const SizedBox(height: 18.0),
                    _provenanceEventDetailTextLineWidget(
                        Text("Agent address",
                            style: genLabelStyle(matchingInfo.agentBcAddress)),
                        BcAddressWidget(
                            bcAddress: data!.agentBcAddress,
                            onTap: () {
                              onTapCopyData("Agent blockchain address",
                                  data!.agentBcAddress);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("User address",
                            style: genLabelStyle(matchingInfo.userBcAddress)),
                        BcAddressWidget(
                            bcAddress: data!.userBcAddress,
                            onTap: () {
                              onTapCopyData("User blockchain address",
                                  data!.userBcAddress);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Id", style: genLabelStyle(matchingInfo.id)),
                        BcAddressWidget(
                            bcAddress: data!.id,
                            onTap: () {
                              onTapCopyData("Id", data!.id);
                            })),
                    const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                    _provenanceEventDetailTextLineWidget(
                        Text("Encrypted message",
                            style:
                                genLabelStyle(matchingInfo.encryptedMessage)),
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
                        Text("Signature", style: labelStyle),
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
                            iconData: Icons.launch,
                            onPressed: () {
                              onTapScanExplorer(data!.explorerId);
                            }))
                  ])
                : const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
    final Color color = isMatched
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.error;
    final TextStyle? titleStyle =
        Theme.of(context).textTheme.headlineSmall?.copyWith(color: color);
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;

    final matchedStatus = Column(children: [
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      SizedBox(
        height: 80.0,
        width: 80.0,
        child: Image.asset("assets/images/status/status_success.png",
            scale: 1, fit: BoxFit.contain),
      ),
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      Text("Matched events", style: titleStyle),
      const SizedBox(height: kAppPaddingBetweenItemSmallSize),
      Text("All information between two events is matched.", style: textStyle),
    ]);
    final unmatchedStatus = Column(children: [
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      SizedBox(
        height: 80.0,
        width: 80.0,
        child: Image.asset("assets/images/status/status_failed.png",
            scale: 1, fit: BoxFit.contain),
      ),
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      Text("Unmatched events", style: titleStyle),
      const SizedBox(height: kAppPaddingBetweenItemSmallSize),
      Text("Exists unmatched information between two events.",
          style: textStyle),
    ]);
    return isMatched ? matchedStatus : unmatchedStatus;
  }
}
