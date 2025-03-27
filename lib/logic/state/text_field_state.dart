

class TextFieldState {
  final String email;
  final String password;
  final String lastName;
  final String fullName;
  final String? emailError;
  final String? passwordError;
  final String? lastNameError;
  final String? usernameError;

  TextFieldState({
    this.email = '',
    this.password = '',
    this.lastName = '',
    this.fullName = '',
    this.emailError,
    this.passwordError,
    this.lastNameError,
    this.usernameError,
  });

  TextFieldState copyWith({
    String? email,
    String? password,
    String? lastName,
    String? fullName,
    String? emailError,
    String? passwordError,
    String? lastNameError,
    String? firstNameError,
  }) {
    return TextFieldState(
      email: email ?? this.email,
      password: password ?? this.password,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      emailError: emailError,
      passwordError: passwordError,
      lastNameError: lastNameError,
      usernameError: usernameError,
    );
  }
}