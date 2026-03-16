import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<ToggleRegisterPasswordVisibility>((event, emit) {
      emit(state.copyWith(obscure: !state.obscure));
    });

    on<RegisterSubmitted>((event, emit) async {
      final nameEmpty = event.username.isEmpty;
      final passEmpty = event.password.isEmpty;
      final passwordsNotMatch =
          event.password != event.confirmPassword;

      if (nameEmpty || passEmpty || passwordsNotMatch) {
        emit(state.copyWith(
          showNameError: nameEmpty,
          showPasswordError: true,
          passwordErrorText: passwordsNotMatch
              ? "Passwords do not match"
              : "Password is required",
        ));
        return;
      }

      emit(state.copyWith(isLoading: true));

      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(
        isLoading: false,
        showNameError: false,
        showPasswordError: false,
        passwordErrorText: null,
      ));
    });
  }
}
