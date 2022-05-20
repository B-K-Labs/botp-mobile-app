import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/botp/provenance/bloc/provenance_bloc.dart';
import 'package:botp_auth/modules/botp/provenance/bloc/provenance_event.dart';
import 'package:botp_auth/modules/botp/provenance/bloc/provenance_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/provenance.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class ProvenanceScreen extends StatelessWidget {
  final ProvenanceInfo provenanceInfo;
  const ProvenanceScreen(this.provenanceInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
        appBarTitle: "Blockchain Provenance",
        body: ProvenanceBody(provenanceInfo));
  }
}

class ProvenanceBody extends StatelessWidget {
  final ProvenanceInfo provenanceInfo;
  const ProvenanceBody(this.provenanceInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProvenanceBloc>(
        create: (context) => ProvenanceBloc(
            authenticatorRepository: context.read<AuthenticatorRepository>())
          ..add(ProvenanceEventGetProvenanceEvents(
              provenanceInfo: provenanceInfo)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_provenanceDetailsSection(), _actionButtons()],
        ));
  }

  Widget _provenanceDetailsSection() {
    return BlocConsumer<ProvenanceBloc, ProvenanceState>(
        listener: (context, state) {
      final SetClipboardStatus copyDataStatus = state.copyDataStatus;
      if (copyDataStatus is SetClipboardStatusSuccess) {
        showSnackBar(context, copyDataStatus.message, SnackBarType.success);
      } else if (copyDataStatus is SetClipboardStatusFailed) {
        showSnackBar(context, copyDataStatus.exception.toString());
      }
    }, builder: (context, state) {
      // Theme
      final TextStyle? _titleStyle = Theme.of(context)
          .textTheme
          .headline6
          ?.copyWith(color: Theme.of(context).colorScheme.primary);
      // Data
      final hasResult = state.getProvenanceStatus is RequestStatusSuccess ||
          state.getProvenanceStatus is RequestStatusFailed;

      return hasResult
          ? Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
              _provenanceStatus(),
              _broadcastEventDetail(),
              _historyEventDetail(),
            ])))
          : Expanded(
              child: Stack(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const SizedBox(height: kAppPaddingTopWithoutAppBarSize),
                Text("It would take a bit!",
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center),
                const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                Text("Getting data from Blockchain",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.center),
              ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Center(child: CircularProgressIndicator())]),
            ]));
    });
  }

  Widget _provenanceStatus() {
    return BlocBuilder<ProvenanceBloc, ProvenanceState>(
        builder: (context, state) {
      return GestureDetector(
          onTap: () {
            context.read<ProvenanceBloc>().add(ProvenanceEventEasterEgg());
          },
          child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kAppPaddingHorizontalSize),
              child: Column(children: [
                ProvenanceStatusWidget(
                    isMatched: state.matchingInfo!.isMatched),
                const SizedBox(height: kAppPaddingBetweenItemNormalSize)
              ])));
    });
  }

  Widget _broadcastEventDetail() {
    return BlocBuilder<ProvenanceBloc, ProvenanceState>(
        builder: (context, state) {
      onTapCopyData(String dataName, String dataValue) {
        context.read<ProvenanceBloc>().add(
            ProvenanceEventCopyData(dataName: dataName, dataValue: dataValue));
      }

      onTapScanExplorer(explorerId) {
        // TODO: Open web view
      }
      return Container(
          padding:
              const EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize),
          child: Column(children: [
            BroadcastEventDetailWidget(
                data: state.broadcastEventData,
                matchingInfo: state.matchingInfo!,
                onTapCopyData: onTapCopyData,
                onTapScanExplorer: onTapScanExplorer),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize)
          ]));
    });
  }

  Widget _historyEventDetail() {
    return BlocBuilder<ProvenanceBloc, ProvenanceState>(
        builder: (context, state) {
      onTapCopyData(String dataName, String dataValue) {
        context.read<ProvenanceBloc>().add(
            ProvenanceEventCopyData(dataName: dataName, dataValue: dataValue));
      }

      onTapScanExplorer(explorerId) {
        // TODO: Open web view
      }
      return Container(
          padding:
              const EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize),
          child: Column(children: [
            HistoryEventDetailWidget(
                data: state.historyEventData,
                matchingInfo: state.matchingInfo!,
                onTapCopyData: onTapCopyData,
                onTapScanExplorer: onTapScanExplorer),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize)
          ]));
    });
  }

  Widget _actionButtons() {
    return BlocBuilder<ProvenanceBloc, ProvenanceState>(
        builder: (context, state) {
      // Widget _returnActionButtons = const SkeletonAvatar(
      //     style: SkeletonAvatarStyle(width: double.infinity, height: 50.0));
      Widget _returnActionButtons = Container();
      if (state.getProvenanceStatus is RequestStatusSuccess ||
          state.getProvenanceStatus is RequestStatusFailed) {
        _returnActionButtons = ButtonNormalWidget(
            text: "Go back",
            onPressed: () {
              Application.router.pop(context);
            });
      }

      return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kAppPaddingHorizontalSize,
              vertical: kAppPaddingVerticalSize),
          child: _returnActionButtons);
    });
  }
}
