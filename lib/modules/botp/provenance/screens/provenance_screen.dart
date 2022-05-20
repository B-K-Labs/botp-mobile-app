import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/widgets/common.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class ProvenanceScreen extends StatelessWidget {
  final ProvenanceInfo provenanceInfo;
  const ProvenanceScreen(this.provenanceInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(body: ProvenanceBody(provenanceInfo));
  }
}

class ProvenanceBody extends StatelessWidget {
  final ProvenanceInfo provenanceInfo;
  const ProvenanceBody(this.provenanceInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProvenanceBloc>(
        create: (context) => TransactionDetailBloc(
            authenticatorRepository: context.read<AuthenticatorRepository>(),
            otpSessionSecretInfo: widget.transactionDetail.otpSessionSecretInfo)
          ..add(TransactionDetailEventGetTransactionDetailAndRunSetupTimers()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_transactionDetailSection(), _actionButtons()],
        ));
    ;
  }
}
