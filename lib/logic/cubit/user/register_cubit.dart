// lib/logic/cubit/register_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/data/models/user/register_model.dart';
import 'package:spotify/data/services/user/Auth.dart';
import 'package:spotify/logic/state/user/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthService _authService;

  RegisterCubit(this._authService) : super(RegisterState());

  void updateFullName(String value) {
    emit(state.copyWith(fullName: value));
  }

  void updateEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void updatePassword(String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> register() async {
    if (state.fullName.isEmpty || state.email.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(error: 'لطفاً همه فیلدها را پر کنید'));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null, success: false));

    try {
      final user = UserRegister(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
      );
      final success = await _authService.registerUser(user);
      if (success) {
        emit(state.copyWith(
          isLoading: false,
          success: true,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          error: 'خطا در ثبت‌نام',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}