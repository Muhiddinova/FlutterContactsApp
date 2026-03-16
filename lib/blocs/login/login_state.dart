
class LoginState {
  final bool isLoading;
  final bool showNameError;
  final bool showPasswordError;
  final bool obscure;

  const LoginState({
    this.isLoading = false,
    this.showNameError = false,
    this.showPasswordError = false,
    this.obscure = true,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? showNameError,
    bool? showPasswordError,
    bool? obscure,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      showNameError: showNameError ?? this.showNameError,
      showPasswordError: showPasswordError ?? this.showPasswordError,
      obscure: obscure ?? this.obscure,
    );
  }
}

