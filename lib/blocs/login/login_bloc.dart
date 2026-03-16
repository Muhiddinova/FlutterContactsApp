

import 'package:bloc/bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginSubmitted>((event, emit) async {
      final showNameError = event.username.isEmpty;
      final showPasswordError = event.password.isEmpty;

      if (showNameError || showPasswordError) {
        emit(state.copyWith(
          showNameError: showNameError,
          showPasswordError: showPasswordError,
        ));
        return;
      }

      emit(state.copyWith(isLoading: true));

      // Fake loading
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(isLoading: false));
    });

    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(obscure: !state.obscure));
    });
  }
}
