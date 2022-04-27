import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/utils/services/clipboard_service.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import 'package:flutter/material.dart';

class AccountAgentInfoScreen extends StatelessWidget {
  final AgentInfo agentInfo;
  const AccountAgentInfoScreen({Key? key, required this.agentInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
        appBarTitle: "Agent info", body: AccountAgentInfoBody(agentInfo));
  }
}

class AccountAgentInfoBody extends StatelessWidget {
  final AgentInfo agentInfo;
  const AccountAgentInfoBody(this.agentInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _agentInfo(context, agentInfo),
      _actionButton(context),
    ]);
  }

  Widget _agentInfo(context, AgentInfo agentInfo) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kAppPaddingHorizontalSize,
            vertical: kAppPaddingVerticalSize),
        child: Column(children: [
          const SizedBox(height: kAppPaddingHorizontalSize),
          AgentInfoWidget(
              agentInfo: agentInfo,
              opTapBcAddress: () async {
                try {
                  await setClipboardData(agentInfo.bcAddress);
                  showSnackBar(context, "Blockchain address copied.",
                      SnackBarType.success);
                } on Exception catch (e) {
                  showSnackBar(context, "Failed to copy blockchain address");
                }
              })
        ]));
  }

  Widget _actionButton(context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kAppPaddingHorizontalSize,
            vertical: kAppPaddingVerticalSize),
        child: ButtonNormalWidget(
            text: "Go back",
            onPressed: () {
              Application.router.pop(context);
            }));
  }
}
