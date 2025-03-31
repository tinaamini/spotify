import 'package:go_router/go_router.dart';
import 'package:spotify/routes/routs_name.dart';
import '../presentation/screens/music/artist.dart';
import '../presentation/screens/music/discovery.dart';
import '../presentation/screens/music/favorite.dart';
import '../presentation/screens/music/home.dart';
import '../presentation/screens/splash/getStarter.dart';
import '../presentation/screens/splash/loading.dart';
import '../presentation/screens/user/Profile.dart';
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
      name: RouteName.home,
      path: "/${RouteName.home}",
      builder: (context, state) => Home(),
    ),
    GoRoute(
      name: RouteName.discoveryScreen,
      path: "/${RouteName.discoveryScreen}",
      builder: (context, state) => DiscoveryScreen(),
    ),
    GoRoute(
      name: RouteName.faveritScreen,
      path: "/${RouteName.faveritScreen}",
      builder: (context, state) => FaveritScreen(),
    ),
    GoRoute(
      name: RouteName.profileScreen,
      path: "/${RouteName.profileScreen}",
      builder: (context, state) => ProfileScreen(),
    ),
  ],
);
