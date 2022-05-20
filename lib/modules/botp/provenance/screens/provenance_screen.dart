import 'package:botp_auth/common/models/common_model.dart';
import "package:flutter/material.dart";

class ProvenanceScreen extends StatelessWidget {
  final ProvenanceInfo provenanceInfo;
  const ProvenanceScreen(this.provenanceInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProvenanceBody(provenanceInfo);
  }
}

class ProvenanceBody extends StatelessWidget {
  final ProvenanceInfo provenanceInfo;
  const ProvenanceBody(this.provenanceInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
