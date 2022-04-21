import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/modules/botp/transaction/cubit/transaction_details_cubit.dart';
import 'package:botp_auth/modules/botp/transaction/cubit/transaction_details_state.dart';
import 'package:botp_auth/widgets/bars.dart';
import 'package:botp_auth/widgets/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionDetail transactionDetail;
  const TransactionDetailsScreen(this.transactionDetail, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBarWidget.generate(context, title: "Authenticate Transaction"),
        body: TransactionDetailsBody(transactionDetail));
  }
}

class TransactionDetailsBody extends StatefulWidget {
  final TransactionDetail transactionDetail;
  const TransactionDetailsBody(this.transactionDetail, {Key? key})
      : super(key: key);

  @override
  State<TransactionDetailsBody> createState() => _TransactionDetailsBodyState();
}

class _TransactionDetailsBodyState extends State<TransactionDetailsBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionDetailsCubit>(
        create: (context) => TransactionDetailsCubit(
            authenticatorRepository: context.read<AuthenticatorRepository>()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_transactionInfoSection(), _otpSection()],
        ));
  }

  Widget _transactionInfoSection() {
    return BlocBuilder<TransactionDetailsCubit, TransactionDetailsState>(
        builder: (context, state) {
      return Container();
    });
  }

  Widget _otpSection() {
    return BlocBuilder<TransactionDetailsCubit, TransactionDetailsState>(
        builder: (context, state) {
      return Column(children: [
        TransactionOTPWidget(otpValueInfo: state.otpValueInfo),
        const TransactionDetailWidget(),
        const TransactionNotifyMessageWidget()
      ]);
    });
  }
}
