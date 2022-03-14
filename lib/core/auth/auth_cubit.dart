import 'package:botp_auth/core/session/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthState { signInCurrent, signInOther, signUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthState.signUp);
  void showSignInCurrent() => emit(AuthState.signInCurrent);
  void showSignInOther() => emit(AuthState.signInOther);
  void showSignUp() => emit(AuthState.signUp);
}
