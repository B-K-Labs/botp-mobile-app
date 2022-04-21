import 'package:botp_auth/common/repositories/authenticator_repository.dart';
import 'package:botp_auth/modules/botp/transaction/cubit/transaction_details_cubit.dart';
import 'package:botp_auth/modules/botp/transaction/cubit/transaction_details_state.dart';
import 'package:botp_auth/widgets/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: const TransactionDetailsBody());
  }
}

class TransactionDetailsBody extends StatefulWidget {
  const TransactionDetailsBody({Key? key}) : super(key: key);

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
