abstract class RegisterEvent {}

class ToggleRegisterPasswordVisibility extends RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final String username;
  final String password;
  final String confirmPassword;

  RegisterSubmitted({
    required this.username,
    required this.password,
    required this.confirmPassword,
  });
}
