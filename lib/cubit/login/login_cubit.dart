import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_my_story_app/data/local/auth_preferences.dart';

import 'package:flutter_my_story_app/data/models/login_response_model.dart';
import 'package:flutter_my_story_app/data/remote/auth_service.dart';

import '../../data/models/request/login_request_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService authService;
  final AuthPreference authPreference;
  LoginCubit(
    this.authService,
    this.authPreference,
  ) : super(LoginInitial());

  void loginUser(LoginRequestModel data) async {
    emit(LoginLoading());
    final result = await authService.login(data);
    result.fold(
      (l) => emit(LoginError(message: l.message)),
      (r) async {
        await authPreference.saveAuthData(r.loginResult);
        emit(LoginLoaded(loginResult: r.loginResult));
      },
    );
  }
}
