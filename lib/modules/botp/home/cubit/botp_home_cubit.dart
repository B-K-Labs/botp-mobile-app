import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/modules/botp/home/cubit/botp_home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Keep track of session & some user data
class BOTPHomeCubit extends Cubit<BOTPHomeState> {
  SessionCubit sessionCubit;
  BOTPHomeCubit({required this.sessionCubit}) : super(BOTPHomeState());

  // readCommonUserData() async {
  //   // Read common used data among 3 main screens
  //   final accountData = await UserData.getCredentialAccountData();
  //   final profileData = await UserData.getCredentialProfileData();
  //   final kycData = await UserData.getCredentialKYCData();
  // }
}
