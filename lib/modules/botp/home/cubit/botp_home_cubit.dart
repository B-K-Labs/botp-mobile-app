import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/modules/botp/home/cubit/botp_home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BOTPHomeCubit extends Cubit<BOTPHomeState> {
  // Keep track of session
  SessionCubit sessionCubit;
  // Store public data globally
  String? bcAddress;
  String? avatarUrl;
  bool? didKYC;
  // List transactions
  // Selected Transaction
  int? selectedTransaction;
  BOTPHomeCubit({required this.sessionCubit}) : super(BOTPHomeState());
}
