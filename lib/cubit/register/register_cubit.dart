import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_my_story_app/data/remote/auth_service.dart';

import '../../data/models/request/register_request_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthService authService;
  RegisterCubit(
    this.authService,
  ) : super(RegisterInitial());

  void registerUser(RegisterRequestModel data) async {
    emit(RegisterLoading());
    final result = await authService.register(data);
    result.fold(
      (l) => emit(RegisterError(message: l.message)),
      (r) => emit(RegsiterLoaded(message: r.message)),
    );
  }
}
