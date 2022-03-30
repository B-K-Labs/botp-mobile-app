import 'package:botp_auth/core/auth/cubit/auth_cubit.dart';
import 'package:botp_auth/core/auth/repositories/auth_repository.dart';
import 'package:botp_auth/core/auth/modules/signup/bloc/signup_event.dart';
import 'package:botp_auth/core/auth/modules/signup/bloc/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepository, required this.authCubit})
      : super(SignUpState()) {
    on<SignUpPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));
    /*on<SignUpSubmitted>((event, emit) {
      try {
        signUpRepository.signUp(state.password);
      }
      catch {

      }
    });*/
  }
}
