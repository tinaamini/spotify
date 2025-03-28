import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/user/Auth.dart';
import '../state/singIn_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthService _apiService;
  SignInCubit(this._apiService): super (SignInState());
  void updateEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void updatePassword(String value) {
    emit(state.copyWith(password: value));
  }
  Future<void> signIn() async {
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(error: 'Please fill in all fields'));
      return;
    }
    emit(state.copyWith(isLoading: true, error: null, accessToken: null));
    try {
      final response = await _apiService.login(state.email, state.password);
      emit(state.copyWith(
        isLoading: false,
        accessToken: response['access_token'],
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }}
}