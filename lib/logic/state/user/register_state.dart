class RegisterState {
  final String fullName;
  final String email;
  final String password;
  final bool isLoading;
  final bool success;
  final String? error;

  RegisterState({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.success = false,
    this.error,
  });

  RegisterState copyWith({
    String? fullName,
    String? email,
    String? password,
    bool? isLoading,
    bool? success,
    String? error,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }
}
// class RegisterState {
//    RegisterState();
// }
// class DataRegister extends RegisterState {
//   final String fullName;
//   final String email;
//   final String password;
//
//    DataRegister({
//     this.fullName = '',
//     this.email = '',
//     this.password = '',
//   });
//
//   DataRegister copyWith({
//     String? fullName,
//     String? email,
//     String? password,
//   }) {
//     return DataRegister(
//       fullName: fullName ?? this.fullName,
//       email: email ?? this.email,
//       password: password ?? this.password,
//     );
//   }
// }
//
// class LoadingRegister extends RegisterState {
//    LoadingRegister();
// }
//
// class SuccessRegister extends RegisterState {
//    SuccessRegister();
// }
//
// class ErrorRegister extends RegisterState {
//   final String message;
//   ErrorRegister(this.message);
// }
//
