class SignInState {
  final String email;
  final String password;
  final bool isLoading;
  final String? accessToken;
  final String? error;

  SignInState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.accessToken,
    this.error,});

  SignInState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? accessToken,
    String? error,}) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      accessToken: accessToken ?? this.accessToken,
      error: error ?? this.error,
    );
  }
}
