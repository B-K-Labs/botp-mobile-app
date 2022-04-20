import 'package:botp_auth/modules/authentication/walkthroughs/cubit/walkthrough_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalkThroughCubit extends Cubit<WalkThroughState> {
  WalkThroughCubit() : super(WalkThroughState());

  changePage(int page) {
    emit(state.copyWith(page: page));
  }
}
