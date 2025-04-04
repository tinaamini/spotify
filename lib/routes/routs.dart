import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/presentation/screens/music/musicPage.dart';
import 'package:spotify/routes/routs_name.dart';
import '../core/di/di.dart';
import '../data/models/music/allMusicModel.dart';
import '../data/models/music/artistmodel.dart';
import '../logic/cubit/music/musicPlayer_cubit.dart';
import '../presentation/screens/music/artist.dart';
import '../presentation/screens/splash/getStarter.dart';
import '../presentation/screens/splash/loading.dart';
import '../presentation/screens/user/Register.dart';
import '../presentation/screens/user/RegisterOrSingUp.dart';
import '../presentation/screens/user/SingIn.dart';
import '../presentation/screens/splash/chooseMode.dart';
import '../presentation/widgets/nav.dart';

final GoRouter router = GoRouter(
  initialLocation: "/Loading",
  routes: [
    GoRoute(
      name: RouteName.registerOrSingUp,
      path: "/RegisterOrSingUp",
      builder: (context, state) => RegisterOrSingUp(),
    ),
    GoRoute(
      name: RouteName.singIn,
      path: "/SingIn",
      builder: (context, state) => SingIn(onTap: () {}),
    ),
    GoRoute(
      name: RouteName.register,
      path: "/Register",
      builder: (context, state) => Register(onTap: () {}),
    ),
    GoRoute(
      name: RouteName.mainHome,
      path: "/MainScreen",
      builder: (context, state) {
        final index = (int.tryParse(state.uri.queryParameters['index'] ?? '0') ?? 0).clamp(0, 4);
        final artistId = int.tryParse(state.uri.queryParameters['artistId'] ?? '0') ?? 0;
        final artistName = state.uri.queryParameters['artistName'] ?? '';
        return MainScreen(initialIndex: index, artistId: artistId,artistName: artistName,);
      },
    ),

    GoRoute(
      name: RouteName.loading,
      path: "/Loading",
      builder: (context, state) => Loading(),
    ),
    GoRoute(
      name: RouteName.getStarter,
      path: "/GetStarter",
      builder: (context, state) => GetStarter(),
    ),
    GoRoute(
      name: RouteName.choosemode,
      path: "/${RouteName.choosemode}",
      builder: (context, state) => Choosemode(),
    ),
    GoRoute(
      name: RouteName.artist,
      path: "/${RouteName.artist}",
      builder: (context, state) => Artist(),
    ),
    GoRoute(
      name: RouteName.musicPage,
      path: "/musicPage",
      builder: (context, state) {
        final Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
        final MusicModel music = extra['music'] as MusicModel;
        final ArtistModel artist = extra['artist'] as ArtistModel;
        final List<MusicModel> musicList = getIt<MusicPlayerCubit>().currentMusicList; //
        return Musicpage(
          initialMusic: music,
          artist: artist,
          musicList: musicList,
        );
      },
    ),

  ],
);
