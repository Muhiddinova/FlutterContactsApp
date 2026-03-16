class RegisterState {
  final bool isLoading;
  final bool showNameError;
  final bool showPasswordError;
  final String? passwordErrorText;
  final bool obscure;

  const RegisterState({
    this.isLoading = false,
    this.showNameError = false,
    this.showPasswordError = false,
    this.passwordErrorText,
    this.obscure = true,
  });

  RegisterState copyWith({
    bool? isLoading,
    bool? showNameError,
    bool? showPasswordError,
    String? passwordErrorText,
    bool? obscure,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      showNameError: showNameError ?? this.showNameError,
      showPasswordError: showPasswordError ?? this.showPasswordError,
      passwordErrorText: passwordErrorText,
      obscure: obscure ?? this.obscure,
    );
  }
}
