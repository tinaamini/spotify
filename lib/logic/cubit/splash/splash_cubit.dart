import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/tokenmanager.dart';
import '../../state/splash/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final TokenManager _tokenManager;

  SplashCubit(this._tokenManager) : super(const SplashState());

  Future<void> checkToken() async {

    await Future.delayed(const Duration(seconds: 2));

    final token = await _tokenManager.getToken();
    final hasToken = token != null && token.isNotEmpty;

    emit(state.copyWith(
      isLoading: false,
      hasToken: hasToken,
    ));
  }
}