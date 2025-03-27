import 'package:bloc/bloc.dart';

import '../state/text_field_state.dart';


class TextFieldCubit extends Cubit<TextFieldState> {
  TextFieldCubit() : super(TextFieldState());

  void updateEmail(String email) {
    String? error;
    if (email.isEmpty) {
      error = "لطفاً ایمیل رو وارد کن";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      error = "ایمیل معتبر نیست";
    }
    emit(state.copyWith(email: email, emailError: error));
  }

  void updatePassword(String password) {
    String? error;
    if (password.isEmpty) {
      error = "لطفاً رمز عبور رو وارد کن";
    } else if (password.length < 6) {
      error = "رمز عبور باید حداقل 6 کاراکتر باشه";
    }
    emit(state.copyWith(password: password, passwordError: error));
  }

  void updateLastName(String lastName) {
    String? error;
    if (lastName.isEmpty) {
      error = "لطفاً نام خانوادگی رو وارد کن";
    } else if (lastName.length < 2) {
      error = "نام خانوادگی باید حداقل 2 حرف باشه";
    }
    emit(state.copyWith(lastName: lastName, lastNameError: error));
  }
  void updatefirstName(String firstName) {
    String? error;
    if (firstName.isEmpty) {
      error = "لطفاً نام  رو وارد کن";
    } else if (firstName.length < 2) {
      error = "نام باید حداقل 2 حرف باشه";
    }
    emit(state.copyWith(lastName: firstName, lastNameError: error));
  }

  bool isFormValid() {
    return state.emailError == null &&
        state.passwordError == null &&
        state.lastNameError == null &&
        state.email.isNotEmpty &&
        state.password.isNotEmpty &&
        state.lastName.isNotEmpty;
  }
}