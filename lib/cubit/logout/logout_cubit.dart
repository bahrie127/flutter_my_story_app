import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_my_story_app/data/local/auth_preferences.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthPreference authPreference;
  LogoutCubit(
    this.authPreference,
  ) : super(LogoutInitial());

  void logout() async {
    emit(LogoutLoading());
    await authPreference.removeAuthData();
    emit(LogoutSuccess());
  }
}
