import 'package:get_it/get_it.dart';
import '../../data/services/music/musicServer.dart';
import '../../data/services/tokenmanager.dart';
import '../../data/services/user/Auth.dart';
import '../../logic/cubit/music/musicPlayer_cubit.dart';
import '../network/api_client.dart';


final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<ApiClient>()));
  getIt.registerSingleton<TokenManager>(TokenManager());
  getIt.registerLazySingleton<MusicServer>(() => MusicServer(getIt<ApiClient>()));
  getIt.registerSingleton<MusicPlayerCubit>(MusicPlayerCubit());
}