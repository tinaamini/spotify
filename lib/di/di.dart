import 'package:get_it/get_it.dart';
import '../data/services/user/Auth.dart';
import '../logic/cubit/music/tab_cubit.dart';
import '../logic/cubit/register_cubit.dart';
import '../logic/cubit/singIn_cubit.dart';


final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton(() => AuthService());

  getIt.registerFactory(() => RegisterCubit(getIt<AuthService>()));
  getIt.registerFactory(() => SignInCubit(getIt<AuthService>()));
  getIt.registerSingleton<TabCubit>(TabCubit());
}